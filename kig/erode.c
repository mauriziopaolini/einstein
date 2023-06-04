#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <math.h>

int
main (int argc, char *argv[])
{
  int numpoints = -1;
  double erode = 0;
  double *x, *y;
  double dxm, dym, dxp, dyp, alpha1, alpha2, alpha3, beta, d;
  double pimezzi = 2*atan(1.0);
  int i;

  if (argc >= 2)
  {
    erode = atof (argv[1]);
  }

  if (argc >= 3) numpoints = atoi (argv[2]);

  if (numpoints < 0)
  {
    scanf ("%d", &numpoints);
  }

  assert (numpoints >= 3);

  x = (double *) malloc ((numpoints + 2) * sizeof (double));
  y = (double *) malloc ((numpoints + 2) * sizeof (double));

  for (i = 1; i <= numpoints; i++)
  {
    scanf ("%lf %lf", &x[i], &y[i]);
  }
  x[0] = x[numpoints];
  y[0] = y[numpoints];
  x[numpoints+1] = x[1];
  y[numpoints+1] = y[1];

  for (i = 1; i <= numpoints; i++)
  {
    dxm = x[i] - x[i-1];
    dym = y[i] - y[i-1];
    dxp = x[i+1] - x[i];
    dyp = y[i+1] - y[i];
    alpha1 = atan2 (dym, dxm);
    alpha2 = atan2 (dyp, dxp);
    beta = alpha1/2.0 - alpha2/2.0 + pimezzi;
    alpha3 = alpha2 + beta;
    d = erode/sin(beta);
    printf ("%lf %lf\n", x[i] + d*cos(alpha3), y[i] + d*sin(alpha3));
    //fprintf (stderr, "angle: %lf %lf, d: %lf\n", alpha1, alpha2, d);
  }
  //for (i = 0; i <= numpoints + 1; i++) fprintf (stderr, "point %d: %lf %lf\n", i, x[i], y[i]);
}
