#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <string.h>
#include <ctype.h>

#define COMMAND_FOLLOW 1
#define COMMAND_HELP 2
#define COMMAND_CHECK 3

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

int prec_in_worm (int sig, int wriggly);
void usage (int argc, char *argv[]);
void printsig (struct signature *sig);
struct signature *readsig (char *repr);

/*
 */

double follow_eo[2][7];

int
main (int argc, char *argv[])
{
  int iarg = 1;
  int wriggly = 0;
  int tipsig = 0;
  int i, sig;
  int command = 0;
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
      } else
      {
        fprintf (stderr, "Invalid option %s\n", argv[iarg]);
        exit (1);
      }
    } else if (command == 0)
    {
      if (strcmp (argv[iarg], "follow") == 0) {
        command = COMMAND_FOLLOW;
      } else if (strcmp (argv[iarg], "check") == 0) {
        command = COMMAND_CHECK;
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
    }
    iarg++;
  }

  assert (rsig);
  printf ("given signature: "); printsig (rsig); printf ("\n");

  if (wriggly) printf ("Option wriggly is ON\n");

  for (i = 0; i < 7; i++) follow_eo[0][i] = follow_eo[1][i] = 0;

  follow_eo[0][2] = 0.43333333;
  follow_eo[0][3] = 2.33333333;
  follow_eo[0][5] = 0.46333333;
  follow_eo[0][6] = 5.33333333;

  follow_eo[1][3] = 4.63333333;
  follow_eo[1][4] = 5.63333333;
  follow_eo[1][5] = 0.23333333;

  switch (command) {
    case COMMAND_HELP:
      usage (argc, argv);
    break;

    case COMMAND_FOLLOW:
      sig = tipsig;
      printf ("%d\n", sig);
      while (sig)
      {
        sig = prec_in_worm (sig, wriggly);
        printf ("%d\n", sig);
      }
    break;

    case COMMAND_CHECK:
      printf ("Not implemented\n");
    break;

    default:
      printf ("Unknown command code: %d\n", command);
      exit (4);
  }

}

struct signature *
readsig (char *chars)
{
  int length;
  char *chpt;
  int endperiodfound = 0;
  struct signature *sig;

  for (chpt = chars, length = 0; *chpt; chpt++)
  {
    if (isdigit (*chpt)) length++;
    if (*chpt == ']') endperiodfound++;
  }

  sig = (struct signature *) malloc (sizeof (struct signature) + length*sizeof (int));

  sig->totlength = sig->allocated = length;
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

  return (sig);
}

int
check (struct signature *sig)
{
  printf ("NOT IMPLEMENTED\n");
  return (0);
}

void
printsig (struct signature *sig)
{
  int i;

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
  printf ("usage: %s [-w] command tile-signature\n", argv[0]);
  printf ("where command can be:\n");
  printf ("  follow\n");
  printf ("  check\n");
  printf ("  help\n");
  return;
}

/*
 * compute prec_in_worm
 */

int
prec_in_worm (int sig, int wriggly)
{
  int tenpow = 1;
  int sigh = sig;
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
  printf ("called with sig = %d, wriggly = %d\n", sig, wriggly);

  return (0);
}
