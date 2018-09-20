/*
 *
 * Uses GCF function from
 *
 *
 * @Book{NRC,
 *   author = 	 {W.H. Press and B.P. Flannery and S.A. Teukolsky and
 *                 W.T. Vetterling},
 *   title = 	 {Numerical Recipes in C: The Art of Scientific Computing},
 *   publisher =  {Cambridge U.P.},
 *   year = 	 {1988},
 *   address = 	 {Cambridge, England},
 * }
 *
 * Simon D. Levy Jeff Hall Lab, Brandeis University 06-JUN-2002 
 */

#include <stdio.h>
#include <math.h>

/* for chisqest */
#define PEPS 0.001

/* for gammln */
#define ITMAX 100
#define EPS 3.0e-7

static float gammln(float xx) {
  
  double x,tmp,ser;
  static double cof[6] = {76.18009173,-86.50532033,24.01409822, 
			  -1.231739516,0.120858003e-2,-0.536382e-5};
  int j;

  x = xx-1.0;
  tmp=x+5.5;
  tmp -= (x+0.5)*log(tmp);
  ser=1.0;
  for (j=0; j<=5; j++) {
    x += 1.0;
    ser += cof[j]/x;
  }
  return -tmp+log(2.50662827465*ser);

}


static void gcf(float *gammcf, float a, float x, float *gln) {

  int n;
  float gold=0.0,g,fac=1.0,b1=1.0;
  float b0=0.0,anf,ana,an,a1,a0=1.0;
  
  *gln=gammln(a);
  a1=x;
  for (n=1; n<=ITMAX; n++) {
    an=(float) n;
    ana=an-a;
    a0=(a1+a0*ana)*fac;
    b0=(b1+b0*ana)*fac;
    anf=an*fac;
    a1=x*a0+anf*a1;
    b1=x*b0+anf*b1;
    if (a1) {
      fac=1.0/a1;
      g=b1*fac;
      if (fabs((g-gold)/g) < EPS) {
	*gammcf=exp(-x+a*log(x)-(*gln))*g;
	return;
      }
      gold = g;
    }
  }    
  fprintf(stderr, "a too large, ITMAX too small in routine GCF\n");
  exit(-1);
}

/* chi-square estimate by binary search */
static float chisqest(double p, int nu) {


    float chilo=1, chihi=100;
    float chisq = 0;
    float pp, q, gln;

    do {
	chisq = (chilo+chihi) / 2;
	gcf(&q, nu/2., chisq/2, &gln);
	pp = 1 - q;
	if (pp < p) { /* estimate too low */
	    chilo = chisq;
	}
	else {        /* estimate too high */
	    chihi = chisq;
	}

    } while (fabs(p-pp) > PEPS);

    return chisq;
}

main(int argc, char **argv) {

  float pmin, pmax, pinc;
  int numin, numax;

  float p;
  int nu;

  if (argc < 6) {
      fprintf(stderr, "Usage: chisq pmin pmax pinc numin numax\n");
      exit(1);
  }

  pmin = atof(argv[1]);
  pmax = atof(argv[2]);
  pinc = atof(argv[3]);
  
  numin = atoi(argv[4]);
  numax = atoi(argv[5]);

  for (p=pmin; p<=pmax; p+=pinc) {
      for (nu=numin; nu<=numax; ++nu) {
	  printf("%3.1f ", chisqest(p, nu));
      }
      printf("\n");
  }
}

