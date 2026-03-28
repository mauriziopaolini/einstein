#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <string.h>
#include <ctype.h>

#define COMMAND_FOLLOW 1
#define COMMAND_HELP 2
#define COMMAND_CHECK 3
#define COMMAND_INFLATE 4
#define COMMAND_DEFLATE 5
#define COMMAND_CHECKWORM 6
#define COMMAND_FOLLOWINT 7

/*
 * data structure to hold a periodic signature
 */

struct signature {
  int totlength;
  int allocated;
  int periodlength;
  int digits[];
};

/*
 * prototypes
 */

void sanitize (struct signature *sig);
long long int prec_in_worm_int (long long int sig, int wriggly);
struct signature *prec_in_worm (struct signature *sig, int wriggly);
int prec_digit (int digit, int wriggly);
void usage (int argc, char *argv[]);
void printsig (struct signature *sig);
struct signature *readsig (char *repr);
void inflate (struct signature *sig);
struct signature *deflate (struct signature *sig, int newdigit);
long long int flatten (struct signature *sig);
int check (struct signature *sig);
int checkworm (struct signature *sig, int wriggly);
struct signature *sigcopy (struct signature *sig);
int isorigin (struct signature *sig);
int isfinite (struct signature *sig);

/*
 */

double follow_eo[2][7];
int follow_eox3[2][7];
static int quiet = 0;
static int precnum = 1000; // default length of follow iterations
static int shortfinite = 0;

int
main (int argc, char *argv[])
{
  int iarg = 1;
  int wriggly = 0;
  long long int tipsig = 0;
  long long int sig;
  int i;
  int command = 0;
  int digit = 0;
  struct signature *rsig = 0;

  if (argc <= 1)
  {
    usage (argc, argv);
    exit (0);
  }
  assert (argc > 1);
  while (iarg < argc)
  {
    if (*argv[iarg] == '-')
    {
      if (strcmp (argv[iarg], "-w") == 0 || strcmp (argv[iarg], "--wriggly") == 0)
      {
        wriggly++;
      } else if (strcmp (argv[iarg], "--digit") == 0) {
        iarg++;
        digit = atoi (argv[iarg]);
      } else if (strcmp (argv[iarg], "--precnum") == 0) {
        iarg++;
        precnum = atoi (argv[iarg]);
      } else if (strcmp (argv[iarg], "--short") == 0) {
        shortfinite++;
      } else if (strcmp (argv[iarg], "-q") == 0) {
        quiet++;
      } else {
        fprintf (stderr, "Invalid option %s\n", argv[iarg]);
        exit (1);
      }
    } else if (command == 0)
    {
      if (strcmp (argv[iarg], "followint") == 0) {
        command = COMMAND_FOLLOWINT;
      } else if (strcmp (argv[iarg], "follow") == 0) {
        command = COMMAND_FOLLOW;
      } else if (strcmp (argv[iarg], "inflate") == 0) {
        command = COMMAND_INFLATE;
      } else if (strcmp (argv[iarg], "deflate") == 0) {
        command = COMMAND_DEFLATE;
      } else if (strcmp (argv[iarg], "check") == 0) {
        command = COMMAND_CHECK;
      } else if (strcmp (argv[iarg], "checkworm") == 0) {
        command = COMMAND_CHECKWORM;
      } else if (strcmp (argv[iarg], "help") == 0) {
        command = COMMAND_HELP;
      } else {
        printf ("Invalid command: %s\n", argv[iarg]);
        exit (3);
      }
    } else
    {
      if (rsig)
      {
        printf ("Extra argument: %s\n", argv[iarg]);
        exit (2);
      }
      rsig = readsig (argv[iarg]);
      sanitize (rsig);
    }
    iarg++;
  }

  if (!quiet && (rsig)) {printf ("given signature: "); printsig (rsig); printf ("\n");}

  if (wriggly && quiet == 0) printf ("Option wriggly is ON\n");

  for (i = 0; i < 7; i++) follow_eox3[0][i] = follow_eox3[1][i] = 0;

  follow_eo[0][2] = 13./30.;
  follow_eo[0][3] = 70./30.;
  follow_eo[0][5] = 139./300.;
  follow_eo[0][6] = 16./3.;

  follow_eo[1][3] = 139./30;
  follow_eo[1][4] = 169./30.;
  follow_eo[1][5] = 7./30.;

  switch (command) {
    case COMMAND_HELP:
      usage (argc, argv);
    break;

    case COMMAND_FOLLOW:
      assert (rsig);
      assert (rsig->periodlength > 0);
      printsig (rsig); printf ("\n");
      i = 1;
      while (!isorigin (rsig))
      {
        rsig = prec_in_worm (rsig, wriggly);
        printsig (rsig); printf ("\n");
        i++;
        if (i > precnum && precnum >= 0) break;
      }
    break;

    case COMMAND_FOLLOWINT:
      assert (rsig);
      tipsig = flatten (rsig);
      if (tipsig < 0)
      {
        printf ("Must have a 'finite' signature: [0]*.\n");
        exit (10);
      }

      sig = tipsig;
      printf ("%lld\n", sig);
      while (sig)
      {
        sig = prec_in_worm_int (sig, wriggly);
        printf ("%lld\n", sig);
      }
    break;

    case COMMAND_INFLATE:
      assert (rsig);
      inflate (rsig);
      printsig (rsig); printf ("\n");
    break;

    case COMMAND_DEFLATE:
      assert (rsig);
      rsig = deflate (rsig, digit);
      printsig (rsig); printf ("\n");
    break;

    case COMMAND_CHECK:
      assert (rsig);
      if (check (rsig))
      {
        printf ("This is a valid signature\n");
      } else {
        printf ("This signatue is invalid\n");
      }
    break;

    case COMMAND_CHECKWORM:
      assert (rsig);
      if (checkworm (rsig, wriggly))
      {
        printf ("This tile belongs to a potential%s worm\n", (wriggly)?" wriggly":"");
      } else {
        printf ("This tile CANNOT belong to a%s worm\n", (wriggly)?" wriggly":"");
      }
    break;

    default:
      printf ("Unknown command code: %d\n", command);
      exit (4);
  }
  free (rsig);
}

/*
 * sanitize: try to reduce the size of the description of sig
 */

void
sanitize (struct signature *sig)
{
  int plen;
  int divisor, periodperiodic, offset;
  int i, newtotlength;

  plen = sig->periodlength;
  assert (sig->periodlength > 0);
  if (plen > 1)
  {
    /*
     * first check if the period is itself periodic with smaller period
     */
    for (divisor = 1; divisor <= plen/2; divisor++)
    {
      if ((plen % divisor) != 0) continue;
      periodperiodic = 1;
      for (offset = 0; offset < divisor; offset++)
      {
        for (i = 1; i < plen/divisor; i++)
        {
          if (sig->digits[offset] != sig->digits[offset + divisor*i])
          {
            periodperiodic = 0;
            break;
          }
        }
        if (periodperiodic == 0) break;
      }
      if (periodperiodic)
      {
        offset = divisor*(plen/divisor - 1);
        newtotlength = sig->totlength - offset;
        for (i = 0; i < newtotlength; i++)
        {
          sig->digits[i] = sig->digits[i + offset];
        }
        sig->periodlength = divisor;
        sig->totlength = newtotlength;
        sanitize (sig);
        return;
      }
    }
  }
  plen = sig->periodlength;
  if (sig->periodlength == sig->totlength) return;
  if (sig->digits[0] == sig->digits[plen])
  {
    /* can shorten totlenght of at least one unit */
    sig->totlength--;
    for (i = 0; i < sig->totlength; i++)
    {
      sig->digits[i] = sig->digits[i+1];
    }
    sanitize (sig);
  }
}

/*
 * flatten: a 'finite' signature with at most 18 digits
 * is converted to a decimal integer
 */

long long int
flatten (struct signature *sig)
{
  int i;
  long long int result = 0;

  assert (sig->periodlength > 0);
  if (sig->periodlength != 1) return (-1);
  if (sig->digits[0] != 0) return (-1);
  if (sig->totlength > 19)
  {
    printf ("Too many digits, they do not fit in a long long integer\n");
    return (-1);
  }

  for (i = 1; i < sig->totlength; i++)
  {
    result *= 10;
    result += sig->digits[i];
  }
  return (result);
}

/*
 * inflate modifies the argument!
 */

void
inflate (struct signature *sig)
{
  int i, rightmost;

  assert (sig->periodlength >= 1);

  if (sig->totlength > sig->periodlength)
  {
    sig->totlength--;
    return;
  }

  /* rotate period right */
  rightmost = sig->digits[sig->periodlength - 1];
  for (i = sig->periodlength - 1; i > 0; i--)
  {
    sig->digits[i] = sig->digits[i-1];
  }
  sig->digits[0] = rightmost;
  return;
}

/*
 * deflate can create a new signature!
 */

struct signature *
deflate (struct signature *sig, int newdigit)
{
  int i;
  struct signature *dsig;

  assert (sig->periodlength >= 1);

  if (sig->allocated > sig->totlength)
  {
    dsig = sig;
  } else {
    dsig = (struct signature *) malloc (sizeof (struct signature) + 2*sig->totlength*sizeof(int));
    dsig->allocated = 2*sig->totlength;
    for (i = 0; i < sig->totlength; i++) dsig->digits[i] = sig->digits[i];
  }

  dsig->digits[sig->totlength] = newdigit;
  dsig->totlength = sig->totlength + 1;
  dsig->periodlength = sig->periodlength;
  if (dsig != sig) free (sig);
  return dsig;
}

struct signature *
readsig (char *chars)
{
  int length;
  char *chpt;
  int endperiodfound = 0;
  int i;
  struct signature *sig;

  for (chpt = chars, length = 0; *chpt; chpt++)
  {
    if (isdigit (*chpt)) length++;
    if (*chpt == ']') endperiodfound++;
  }

  sig = (struct signature *) malloc (sizeof (struct signature) + (length+1)*sizeof (int));

  sig->allocated = length + 1;
  sig->totlength = length;

  sig->periodlength = 0; /* this would indicate an actual period of [0] */
  for (chpt = chars, length = 0; *chpt; chpt++)
  {
    if (isdigit (*chpt))
    {
      sig->digits[length] = *chpt - '0';
      length++;
    }
    if (*chpt == ']') sig->periodlength = length;
  }

  if (endperiodfound == 0)
  {
    assert (sig->periodlength == 0);
    assert (sig->allocated > sig->totlength);

    for (i = sig->totlength; i > 0; i--)
    {
      sig->digits[i] = sig->digits[i-1];
    }
    sig->digits[0] = 0;
    sig->totlength++;
    sig->periodlength++;
  }

  return (sig);
}

/*
 * check for a valid signature
 */

int
check (struct signature *sig)
{
  int i;

  for (i = 0; i < sig->totlength; i++)
  {
    if (sig->digits[i] < 0 || sig->digits[i] > 7) {printf ("Digits cannot be negative nor larger then 7\n"); return (0);}
  }
  for (i = 0; i < sig->totlength - 1; i++)
  {
    if (sig->digits[i] == 0 && sig->digits[i+1] == 3) {printf ("\"..03..\" is not allowed in signature\n"); return (0);}
  }
  if (sig->digits[0] == 3 && sig->digits[sig->periodlength - 1] == 0)
  {
    printf ("\"..03..\" is not allowed in signature: [3..0]..\n"); return (0);
  }
  return (1);
}

/*
 * checkworm
 */

int
checkworm (struct signature *sig, int wriggly)
{
  int ok, i, lastdigit;
  struct signature *csig;

  assert (wriggly == 0 || wriggly == 1);
  csig = sigcopy (sig);

  ok = 1;
  for (i = 0; i < csig->totlength + csig->periodlength + 1; i++)
  {
    lastdigit = csig->digits[csig->totlength - 1];
//printf ("csig: "); printsig (csig); printf (" wriggly=%d, lastdigit: %d\n", wriggly, lastdigit);
    switch (lastdigit)
    {
      case 0:
      case 3:
      case 5:
      break;

      case 1:
      case 7:
        ok = 0;
      break;

      case 2:
      case 6:
        if (wriggly) ok = 0;
      break;

      case 4:
        if (wriggly == 0) ok = 0;
      break;

      default:
        printf ("Invalid digit %d\n", lastdigit);
      break;
    }

    if (ok == 0) break;
    inflate (csig);
    wriggly = 1 - wriggly;
  }

  free (csig);
  return (ok);
}

int
isorigin (struct signature *sig)
{
  int i;

  for (i = 0; i < sig->totlength; i++)
  {
    if (sig->digits[i] != 0) return (0);
  }
  return (1);
}

int
isfinite (struct signature *sig)
{
  int i;

  if (sig->periodlength == 0) return (1);
  for (i = 0; i < sig->periodlength; i++)
  {
    if (sig->digits[i] != 0) return (0);
  }
  return (1);
}

void
printsig (struct signature *sig)
{
  int i;

  if (shortfinite)
  {
    if (isorigin (sig)) {printf ("0"); return;}
    if (isfinite (sig))
    {
      for (i = 0; i < sig->totlength && sig->digits[i] == 0; i++);
      while (i < sig->totlength) printf ("%d", sig->digits[i++]);
      return;
    }
  }

  if (sig->periodlength == 0)
  {
    printf ("[0]");
    i = 0;
  } else {
    printf ("[");
    for (i = 0; i < sig->periodlength; i++)
    {
      printf ("%d", sig->digits[i]);
    }
    printf ("]");
  }
  for (i = sig->periodlength; i < sig->totlength; i++)
  {
    printf ("%d", sig->digits[i]);
  }
  printf (".");
}

void
usage (int argc, char *argv[])
{
  printf ("usage: %s [-w][-q] command tile-signature\n", argv[0]);
  printf ("where command can be:\n");
  printf ("  follow\n");
  printf ("  check\n");
  printf ("  inflate\n");
  printf ("  deflate\n");
  printf ("  checkworm\n");
  printf ("  help\n");
  printf ("\nOptions:\n");
  printf ("  -w   worm is wriggly\n");
  printf ("  -q   be quiet\n");
  return;
}

/*
 * compute prec_in_worm
 */

struct signature *
prec_in_worm (struct signature *sig, int wriggly)
{
  int i, numzeros;
  int lastdigit;
  struct signature *dsig;

  assert (wriggly == 0 || wriggly == 1);
  lastdigit = sig->digits[sig->totlength - 1];
  if (lastdigit != 0)
  {
    lastdigit = prec_digit (lastdigit, wriggly);
    if (sig->totlength == sig->periodlength)
    {
      assert (sig->totlength <= sig->allocated);
      if (sig->totlength == sig->allocated)
      {
        dsig = (struct signature *) malloc (sizeof (struct signature) + 2*sig->totlength*sizeof(int));
        dsig->allocated = 2*sig->totlength;
        dsig->totlength = sig->totlength;
        dsig->periodlength = sig->periodlength;
        for (i = 0; i < sig->totlength; i++) dsig->digits[i] = sig->digits[i];
        free (sig);
        sig = dsig;
      }
      assert (sig->totlength < sig->allocated);
      for (i = sig->totlength; i > 0; i--)
      {
        sig->digits[i] = sig->digits[i-1];
      }
      sig->digits[0] = sig->digits[sig->periodlength];
      sig->totlength++;
    }
    sig->digits[sig->totlength - 1] = lastdigit;
    sanitize (sig);
    return (sig);
  }
  for (i = sig->totlength - 1, numzeros = 0; i >= 0 && sig->digits[i] == 0; i--, numzeros++) {};
  assert (numzeros > 0);
  lastdigit = sig->digits[sig->totlength - 1 - numzeros];
  inflate (sig);
  sig = prec_in_worm (sig, 1 - wriggly);
  switch (numzeros)
  {
    case 1:
      if (wriggly) {
        switch (lastdigit)
        {
          case 2:
          case 5:
            sig = deflate (sig, 4);
          break;
          case 3:
          case 6:
            sig = deflate (sig, 3);
          break;
          default:
            assert (0);
          break;
        }
      } else {
        switch (lastdigit)
        {
          case 3:
          case 4:
            sig = deflate (sig, 6);
          break;
          case 5:
            sig = deflate (sig, 2);
          break;
          default:
            assert (0);
          break;
        }
      }
    break;

    case 2:
      if (wriggly) {
        sig = deflate (sig, 3);
      } else {
        switch (lastdigit)
        {
          case 2:
          case 3:
          case 6:
            sig = deflate (sig, 3);
          break;
          case 5:
            sig = deflate (sig, 6);
          break;
          default:
            assert (0);
          break;
        }
      }
    break;

    default:
      sig = deflate (sig, 3);
    break;
  }
  return (sig);
}

/*
 * prec_digit
 * compute the new last digit of prec in worm if it is nonzero
 */

int
prec_digit (int digit, int wriggly)
{
  assert (digit != 0);
  if (wriggly)
  {
    switch (digit)
    {
      case 3:
        return (4);
      break;
      case 4:
        return (5);
      break;
      case 5:
        return (0);
      break;
      default:
        fprintf (stderr, "Invalid last digit for wriggly worm\n");
        exit (11);
    }
  }
  switch (digit)
  {
    case 3:
      return (2);
    break;
    case 2:
      return (0);
    break;
    case 6:
      return (5);
    break;
    case 5:
      return (0);
    break;
    default:
      fprintf (stderr, "Invalid last digit for worm\n");
      exit (11);
  }
}

/*
 * compute prec_in_worm_int
 */

long long int
prec_in_worm_int (long long int sig, int wriggly)
{
  long long int tenpow = 1;
  long long int sigh = sig;
  int eo = wriggly;
  int sym;


  while (sigh)
  {
    sym = sigh % 10;
    sigh /= 10;
    //printf ("=== sigh = %d, sym = %d\n", sigh, sym);
    if (sym)
    {
      assert (follow_eo[eo][sym]);
      sym = (int) tenpow*follow_eo[eo][sym];
      return (10*tenpow*sigh + sym);
    }

    tenpow *= 10;
    eo = 1 - eo;
  }


  printf ("Case sym = 0 is not dealt with yet\n");
  printf ("called with sig = %lld, wriggly = %d\n", sig, wriggly);

  return (0);
}

/*
 * copy a signature
 */

struct signature *
sigcopy (struct signature *sig)
{
  int i;
  struct signature *rsig;

  rsig = (struct signature *) malloc (sizeof (struct signature) + sig->allocated*sizeof (int));

  rsig->allocated = sig->allocated;
  rsig->totlength = sig->totlength;
  rsig->periodlength = sig->periodlength;

  for (i = 0; i < sig->totlength; i++) rsig->digits[i] = sig->digits[i];

  return rsig;
}
