#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <string.h>
#include <math.h>

/*
 * leggi un OFF e convertilo in ascii stl
 */

struct vertex {
    int id;
    double xyz[3];
  };

struct face {
    int id;
    struct vertex *v[3];
    int rgba[4];
  };

#define BUFSIZE 1000

void computenormal (struct face *face, double *xpt, double *ypt, double *zpt);

int
main (int argc, char *argv[])
{
  char line[BUFSIZE];
  char *linept;
  size_t linesize;
  int chars;
  long nvertices, nedges, nfaces;
  int offread = 0;
  struct vertex *vertices, *vertex;
  struct face *faces, *face;
  int i, j, iv;
  double nx, ny, nz;

  nvertices = nfaces = nedges = 0;

  while (1)
  {
    linept = line;
    linesize = BUFSIZE - 1;
    chars = getline (&linept, &linesize, stdin);
    if (chars < 0) break;
    if (linept != line)
    {
      fprintf (stderr, "FATAL: line too long: %uld\n", linesize);
      free (linept);
      exit (1);
    }
    if (line[0] == '#' || chars == 1)
    {
      // fprintf (stderr, "comment %s", linept);
      continue;
    }
    if (offread == 0)
    {
      if (strcmp (line, "OFF\n") == 0)
      {
        printf ("solid off2stl\n");
        offread++;
        continue;
      } else {
        fprintf (stderr, "FATAL: file must start with OFF\n");
        exit (2);
      }
    }
    if (nvertices == 0)
    {
      linept = line;
      nvertices = strtol (linept, &linept, 10);
      nfaces = strtol (linept, &linept, 10);
      nedges = strtol (linept, &linept, 10);
      break;
    }
  }

  /*
   * now read data
   */

  vertices = (struct vertex *) malloc (nvertices*sizeof(struct vertex));
  faces = (struct face *) malloc (nfaces*sizeof(struct face));

  for (i = 0; i < nvertices; i++)
  {
    linept = line;
    linesize = BUFSIZE - 1;
    chars = getline (&linept, &linesize, stdin);
    if (chars < 0) break;
    if (linept != line)
    {
      fprintf (stderr, "FATAL: line too long: %uld\n", linesize);
      free (linept);
      exit (1);
    }
    linept = line;

    vertex = &vertices[i];
    vertex->id = i;
    for (j = 0; j < 3; j++) vertex->xyz[j] = strtod (linept, &linept);
  }

  for (i = 0; i < nfaces; i++)
  {
    linept = line;
    linesize = BUFSIZE - 1;
    chars = getline (&linept, &linesize, stdin);
    if (chars < 0) break;
    if (linept != line)
    {
      fprintf (stderr, "FATAL: line too long: %uld\n", linesize);
      free (linept);
      exit (1);
    }
    linept = line;

    face = &faces[i];
    iv = strtol (linept, &linept, 10);
    assert (iv == 3);
    for (j = 0; j < 3; j++)
    {
      iv = strtol (linept, &linept, 10);
      face->v[j] = vertices + iv;
    }
    for (j = 0; j < 4; j++) face->rgba[j] = strtol (linept, &linept, 10);
  }

  /*
  for (i = 0; i < nvertices; i++)
  {
    vertex = &vertices[i];
    if (vertex->id < 0) continue;
    vertex->id = i;
  }
   */

  for (i = 0; i < nfaces; i++)
  {
    face = &faces[i];
    computenormal (face, &nx, &ny, &nz);
    printf ("facet normal %lf %lf %lf\n", nx, ny, nz);
    printf (" outer loop\n");
    for (j = 0; j < 3; j++)
    {
      vertex = face->v[j];
      printf ("  vertex %lf %lf %lf\n", vertex->xyz[0], vertex->xyz[1], vertex->xyz[2]);
    }
    printf (" endloop\n");
    printf ("endfacet\n");
  }

  printf ("endsolid tile\n");
}

void
computenormal (struct face *face, double *xpt, double *ypt, double *zpt)
{
  struct vertex *v1, *v2, *v3;
  double a[3], b[3], norm;
  int j;

  v1 = face->v[0];
  v2 = face->v[1];
  v3 = face->v[2];
  for (j = 0; j < 3; j++)
  {
    a[j] = v2->xyz[j] - v1->xyz[j];
    b[j] = v3->xyz[j] - v1->xyz[j];
  }

  *xpt = a[1]*b[2] - a[2]*b[1];
  *ypt = a[2]*b[0] - a[0]*b[2];
  *zpt = a[0]*b[1] - a[1]*b[0];

  norm = sqrt (*xpt * *xpt + *ypt * *ypt + *zpt * *zpt);

  *xpt /= norm;
  *ypt /= norm;
  *zpt /= norm;

  return;
}
