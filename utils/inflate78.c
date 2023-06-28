#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <string.h>

#define MAXLEN 10000

/*
 * templates
 */

int checkstring (char *string);

/*
 * =====================================
 */

int
main (int argc, char *argv[])
{
  int len;
  char string[MAXLEN+1];
  char istring[MAXLEN+1];
  char dstring[MAXLEN+1];

  fgets (string, MAXLEN+1, stdin);

  len = strlen (string);
  if (string[len-1] == '\n')
  {
    string[len-1] = 0;
    len--;
  }

  printf ("len: %d\n", len);

  if (!checkstring (string)) exit (1);

  printf ("XX%sXX\n", string);
}

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
