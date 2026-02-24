#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <string.h>

/*
 * prototypes
 */

int prec_in_worm (int sig, int wriggly);

/*
 */

double follow_eo[2][7];

int
main (int argc, char *argv[])
{
  int iarg = 0;
  int wriggly = 0;
  int tipsig = 0;
  int i, sig;

  assert (argc > 1);
  while (iarg < argc)
  {
    if (*argv[iarg] == '-')
    {
      if (strcmp (argv[iarg], "-w") == 0 || strcmp (argv[iarg], "--wriggly") == 0)
      {
        wriggly++;
      } else {
        fprintf (stderr, "Invalid option %s\n", argv[iarg]);
        exit (1);
      }
    } else {
      tipsig = atoi (argv[iarg]);
    }
    iarg++;
  }

  if (wriggly) printf ("Option wriggly is ON\n");

  for (i = 0; i < 7; i++) follow_eo[0][i] = follow_eo[1][i] = 0;

  follow_eo[0][2] = 0.43333333;
  follow_eo[0][3] = 2.33333333;
  follow_eo[0][5] = 0.46333333;
  follow_eo[0][6] = 5.33333333;

  follow_eo[1][3] = 4.63333333;
  follow_eo[1][4] = 5.63333333;
  follow_eo[1][5] = 0.23333333;

  sig = tipsig;
  printf ("%d\n", sig);
  while (sig)
  {
    sig = prec_in_worm (sig, wriggly);
    printf ("%d\n", sig);
  }
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
