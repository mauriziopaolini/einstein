#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <string.h>

#define MAXLEN 100000
#define SIGLEN 100

/*
 * templates
 */

int checkstring (char *string);
int inflate (char *istring, char *string, int *iindex, int index);

/*
 * =====================================
 */

int
main (int argc, char *argv[])
{
  int len, index, iindex;
  int isig = 0;
  char string[MAXLEN+1];
  char istring[MAXLEN+1];
  char signature[SIGLEN];
  char sig;

  assert (argc >= 3);
  assert (strcmp (argv[1], "--index") == 0);
  index = atoi (argv[2]);

  fgets (string, MAXLEN+1, stdin);

  len = strlen (string);
  if (string[len-1] == '\n')
  {
    string[len-1] = 0;
    len--;
  }

  //printf ("string:  %s\n", string);
  //printf ("index: %d\n", index);
  if (!checkstring (string)) exit (1);
  while (1)
  {
    sig = inflate (istring, string, &iindex, index-1);
    iindex++;
    if (!checkstring (istring)) exit (1);
    //printf ("istring: %s\n", istring);
    //printf ("index: %d, signature: %c\n", iindex, sig);
    strcpy (string, istring);
    index = iindex;
    signature[isig++] = sig;
    if (sig == 0) break;
  }


  printf ("signature: %s\n", signature);
}

/* ========================================================= */

int
inflate (char *istring, char *string, int *iindex, int index)
{
  int i, ii;
  char signature, ns;

  *iindex = -1;
  signature = 0;

  for (i = 0, ii = 0; i < strlen(string); i++)
  {
    ns = 0;
    if (string[i] != '7') continue;
    if (string[i+1] != '8') break;
    if (string[i+2] == 0) break;
    if (string[i+2] == '8')
    {
      istring[ii++] = '8';
      if (index == i) ns = '0';
      if (index == i+1) ns = '2';
      if (index == i+2) ns = '6';
      i += 2;
    } else {
      assert (string[i+2] == '7');
      istring[ii++] = '7';
      if (index == i) ns = '0';
      if (index == i+1) ns = '2';
      i += 1;
    }
    if (ns) {signature = ns; *iindex = ii-1;}
  }
  istring[ii] = 0;
  return (signature);
}

/* ========================================================= */

int
checkstring (char *string)
{
  int i, len, count7, count8;
  len = strlen (string);

  count7 = count8 = 0;
  for (i = 0; i < len; i++)
  {
    if (string[i] != '7' && string[i] != '8')
    {
      fprintf (stderr, "FATAL: invalid character '%c' in string\n", string[i]);
      return (0);
    }
    if (string[i] == '7')
    {
      if (count7++ > 0) {fprintf (stderr, "FATAL: cannot have 2 consecutive '7'\n"); return (0);}
      count8 = 0;
      continue;
    } else {
      if (count8++ > 1) {fprintf (stderr, "FATAL: cannot have 3 consecutive '8'\n"); return (0);}
      count7 = 0;
    }
  }

  return (1);
}
