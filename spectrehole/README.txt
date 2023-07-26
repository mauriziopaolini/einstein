We have two symmetric shapes of the hole: star (a twelve-pointed star)
and a hexagon with side 2.

We can revert each of the six worms arriving at the star-shaped hole; each
reversal entail a decreas in the hole area of 3 units (the spectre has sides
of length 1).

Knowing that the area of the star is approx 28.3923 and that the spectre
tile has area 8.19615, we can compute the number n_i of tiles that would be
necessary to add in order to fill the hole when we revert i worms:

i n_i
-----
0 3.46410
1 3.09807
2 2.73205
3 2.36603
4 2.00000
5 1.63397
6 1.26795

From which we infer that the only compatible number
of worms to revert in order to close the hole is 4

octave:2> spectre=8.19615
spectre = 8.196149999999999
octave:3> star=28.3923
star = 28.39230000000000
octave:4> farfalla=28.3923
farfalla = 28.39230000000000
octave:5> n0=star/spectre
n0 = 3.464102047912740
octave:6> n1=(star-farfalla)/spectre
n1 = 0
octave:7> farfalla=3
farfalla = 3
octave:8> esagono=2*sqrt(3)*3
esagono = 10.39230484541326
octave:9> (star-6*farfalla)
ans = 10.39230000000000
octave:10> n1=(star-farfalla)/spectre
n1 = 3.098076535934555
octave:11> n2=(star-2*farfalla)/spectre
n2 = 2.732051023956370
octave:12> n3=(star-3*farfalla)/spectre
n3 = 2.366025511978185
octave:13> n4=(star-4*farfalla)/spectre
n4 = 2
octave:14> n5=(star-5*farfalla)/spectre
n5 = 1.633974488021815
octave:15> n6=(star-6*farfalla)/spectre
n6 = 1.267948976043630

