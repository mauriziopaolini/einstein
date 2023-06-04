#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <string.h>

static int tooff = 1;
static int tostl = 0;
static double *twodcoordx;
static double *twodcoordy;
static int verbose = 0;

/* prototipi */

int writeoff (double height, int nvertices, int ntriangles, int nedges);
int writestl (double height, int nvertices, int ntriangles, int nedges);

int
main (int argc, char *argv[])
{
  int iarg, i;
  int nvertices, ntriangles, nedges;
  double height = 0.0;
  int flag;

  for (iarg = 1; iarg < argc; iarg++)
  {
    if (strcmp (argv[iarg], "--off") == 0) {tooff++; continue;}
    if (strcmp (argv[iarg], "--stl") == 0) {tostl++; continue;}
    if (strcmp (argv[iarg], "--verbose") == 0) {verbose++; continue;}

    assert (height == 0.0);
    height = atof (argv[iarg]);
  }

  assert (tooff + tostl == 1);
  assert (height > 0.0);

  scanf ("%d %d %d", &nvertices, &ntriangles, &nedges);

  if (verbose) fprintf (stderr, "MSH: height: %lf\n", height);
  if (verbose) fprintf (stderr, "MSH: %d vertices, %d triangles, %d edges\n", nvertices, ntriangles, nedges);

  twodcoordx = (double *) malloc (nvertices*sizeof(double));
  twodcoordy = (double *) malloc (nvertices*sizeof(double));

  for (i = 0; i < nvertices; i++)
  {
    scanf ("%lf %lf %d", twodcoordx+i, twodcoordy+i, &flag);
    if (verbose) fprintf (stderr, "MSH: %d: (%lf, %lf)\n", i, twodcoordx[i], twodcoordy[i]);
  }

  if (tooff) writeoff (height, nvertices, ntriangles, nedges);
  if (tostl) writestl (height, nvertices, ntriangles, nedges);
}

int
writeoff (double h, int nv, int nt, int ne)
{
  int nv3d, nf3d, ne3d;
  int i, i1, i2, i3, idummy;

  nv3d = 2*nv;
  nf3d = 2*nt + 2*ne;
  ne3d = nv3d + nf3d - 2;

  printf ("OFF\n#\n# created by msh2stl --off\n#\n");
  printf ("%d %d %d\n", nv3d, nf3d, ne3d);

  for (i = 0; i < nv; i++)
  {
    printf ("%lf %lf %lf\n", twodcoordx[i], twodcoordy[i], 0.0);
    printf ("%lf %lf %lf\n", twodcoordx[i], twodcoordy[i], h);
  }

  /* triangoli di base e soffitto */

  for (i = 0; i < nt; i++)
  {
    scanf ("%d %d %d %d", &i1, &i2, &i3, &idummy);
    i1--; i2--; i3--;
    if (verbose) fprintf (stderr, "MSH: %d %d %d\n", i1, i2, i3);
    printf ("3 %d %d %d 255 0 0 0\n", 2*i1, 2*i3, 2*i2);
    printf ("3 %d %d %d 0 255 0 0\n", 2*i1+1, 2*i2+1, 2*i3+1);
  }

  /* triangoli laterali */

  for (i = 0; i < ne; i++)
  {
    scanf ("%d %d %d", &i1, &i2, &idummy);
    i1--; i2--;
    if (verbose) fprintf (stderr, "MSH edge: %d %d\n", i1, i2);
    printf ("3 %d %d %d 0 0 255 0\n", 2*i1, 2*i2, 2*i1+1);
    printf ("3 %d %d %d 0 0 255 0\n", 2*i2, 2*i2+1, 2*i1+1);
  }

  return (1);
}

int
writestl (double h, int nv, int nt, int ne)
{
  fprintf (stderr, "NOT IMPLEMENTED\n");
  return (-1);
}
