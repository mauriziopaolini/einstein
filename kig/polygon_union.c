/*
 * this is a filter that reads a list of polygons and produces their
 * union
 * the polygons cannot have internal points in common
 */

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <math.h>

struct polygon {
  struct polygon *next;
  int len;
  int allocated;
  double xy[][2];
};

/*
 * prototypes
 */

struct polygon *read_polygons_list (void);
struct polygon *read_polygon (void);
void print_polygon (struct polygon *p);
void find_starting_point (struct polygon *p, double *xpt, double *ypt);
int multiplicity (struct polygon *pols, double x, double y);
int check_same_old (struct polygon *p, int i, struct polygon *q, int j);
int check_same (struct polygon *p, int i, double x, double y);
int check_same_pos (double x1, double y1, double x2, double y2);
void follow (struct polygon *pols, double *xpt, double *ypt);



int
main (int argc, char *argv[])
{
  int polcount = 0;
  int totlenbound = 0;
  struct polygon *polygon, *polygons, *unionpol;
  double xs, ys, x, y;

  polygons = read_polygons_list ();
  assert (polygons);

  for (polygon = polygons; polygon; polygon = polygon->next)
  {
    polcount++;
    totlenbound += polygon->len;
    //print_polygon (polygon);
  }

  fprintf (stderr, "Read %d polygons, totlenbound: %d\n", polcount, totlenbound);

  unionpol = (struct polygon *) malloc (sizeof (struct polygon) + 2*totlenbound*sizeof (double));
  unionpol->allocated = totlenbound;
  unionpol->next = 0;
  unionpol->len = 0;

  find_starting_point (polygons, &xs, &ys);
  unionpol->xy[unionpol->len][0] = xs;
  unionpol->xy[unionpol->len][1] = ys;
  unionpol->len++;

  assert (multiplicity (polygons, xs, ys) == 1);
  fprintf (stderr, "starting point: (%lf,%lf)\n", xs, ys);

  x = xs; y = ys;
  while (1)
  {
    follow (polygons, &x, &y);
    //fprintf (stderr, "next point: (%lf,%lf)\n", x, y);
    if (check_same_pos (x, y, xs, ys)) break;
    unionpol->xy[unionpol->len][0] = x;
    unionpol->xy[unionpol->len][1] = y;
    unionpol->len++;
  }

  print_polygon (unionpol);
  printf ("0\n1\n");
}


int
multiplicity (struct polygon *pols, double x, double y)
{
  int m = 0;
  int i;
  struct polygon *p;

  for (p = pols; p; p = p->next)
  {
    for (i = 0; i < p->len; i++)
    {
      if (check_same (p, i, x, y)) m++;
    }
  }
  return (m);
}

void
follow (struct polygon *pols, double *xpt, double *ypt)
{
  int i, iplus, m, ms;
  struct polygon *p;
  double x, y;

  ms = multiplicity (pols, *xpt, *ypt);
  for (p = pols; p; p = p->next)
  {
    for (i = 0; i < p->len; i++)
    {
      if (check_same (p, i, *xpt, *ypt))
      {
        iplus = (i + 1) % p->len;
        x = p->xy[iplus][0];
        y = p->xy[iplus][1];
        m = multiplicity (pols, x, y);
        if (ms == 1 || m == 1)
        {
          *xpt = x;
          *ypt = y;
          return;
        }
        assert (m > 1);
      }
    }
  }
  fprintf (stderr, "FATAL: cannot find suitable following point for (%lf,%lf)\n", *xpt, *ypt);
  exit (2);
  return;
}

void
find_starting_point (struct polygon *pols, double *xpt, double *ypt)
{
  int i, j, isdup;
  struct polygon *p, *q;

  for (p = pols; p; p = p->next)
  {
    for (i = 0; i < p->len; i++)
    {
      isdup = 0;
      for (q = p->next; q; q = q->next)
      {
        for (j = 0; j < q->len; j++)
        {
          //if (check_same_old (p, i, q, j)) isdup++;
          if (check_same (p, i, q->xy[j][0], q->xy[j][1])) isdup++;
          if (isdup) break;
        }
        if (isdup) break;
      }
      if (isdup == 0)
      {
        *xpt = p->xy[i][0];
        *ypt = p->xy[i][1];
        return;
      }
    }
  }
}

int
check_same_pos (double x1, double y1, double x2, double y2)
{
  if (fabs (x1 - x2) > 1e-5) return (0);
  if (fabs (y1 - y2) > 1e-5) return (0);
  return (1);
}

int
check_same (struct polygon *p, int i, double x, double y)
{
  double x1, y1;

  x1 = p->xy[i][0];
  y1 = p->xy[i][1];

  if (fabs (x1 - x) > 1e-5) return (0);
  if (fabs (y1 - y) > 1e-5) return (0);
  return (1);
}

int
check_same_old (struct polygon *p, int i, struct polygon *q, int j)
{
  double x1, y1, x2, y2;

  x1 = p->xy[i][0];
  y1 = p->xy[i][1];
  x2 = q->xy[j][0];
  y2 = q->xy[j][1];

  if (fabs (x1 - x2) > 1e-5) return (0);
  if (fabs (y1 - y2) > 1e-5) return (0);
  return (1);
}

struct polygon *
read_polygons_list (void)
{
  struct polygon *polygon, *polygonlist;

  polygonlist = 0;
  while ((polygon = read_polygon()))
  {
    polygon->next = polygonlist;
    polygonlist = polygon;
  }

  return (polygonlist);
}

struct polygon *
read_polygon (void)
{
  int i, len;
  struct polygon *polygon;

  scanf ("%d", &len);
  if (len <= 0) return (0);
  polygon = (struct polygon *) malloc (sizeof (struct polygon) + 2*len*sizeof (double));

  polygon->next = 0;
  polygon->len = len;
  polygon->allocated = len;
  for (i = 0; i < len; i++)
  {
    scanf ("%lf %lf", &polygon->xy[i][0], &polygon->xy[i][1]);
  }
  return (polygon);
}

void
print_polygon (struct polygon *p)
{
  int i;

  printf ("%d\n", p->len);
  for (i = 0; i < p->len; i++)
  {
    printf ("%lf %lf\n", p->xy[i][0], p->xy[i][1]);
  }
}

