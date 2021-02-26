#define _GNU_SOURCE
#include <pthread.h>
#include <semaphore.h>
#include <stdio.h>
#include <stdlib.h>
#include <signal.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>
#include <stdbool.h>  
#include <assert.h>  
#include <string.h>
#include "xerrors.h"

// es1: ok
// es2: imperfezione e manca parte segnali
// voto: 28

 
 //Struttura dati della cond_variable
typedef struct{
  int nletti;
  pthread_cond_t cond;
  pthread_mutex_t mutex_cond;
}cond_var;

 //Struttura dati da passare ai thread
typedef struct{
  int n;
  pthread_mutex_t *mutex_thread;
  FILE *f;  
  cond_var *c1;
}dati;

bool primo(int n);

//Corpo dei thread secondari, devono vedere il numero passato a loro e vedere quali sono
//i suoi primi e scriverglieli difianco nel file outfile
void *tbody(void *arg){
  dati *a= (dati*) arg;
  int primi[a->n];
  int j=0;
  //Calcolo i suoi primi e li metto in un array secondario
  for(int i=2;i<a->n;i++)
    if(a->n%i == 0)
      if(primo(i))
        primi[j++]=i;
  //Parte critica lock il mutex per scrittura su file
  xpthread_mutex_lock(a->mutex_thread,__LINE__,__FILE__);
  //Scrivo sul file il numero n
  fprintf(a->f,"%d :",a->n);
  //Scrivo sul file i suoi divisori
  for(int i=0;i<j;i++)
    fprintf(a->f," %d",primi[i]);
  //Infine vado a capo
  fprintf(a->f,"\n");
  //Tolgo il mutex per file avendo oramai scritto i miei numeri
  xpthread_mutex_unlock(a->mutex_thread,__LINE__,__FILE__);
  //Incremento cond variable. Prima lock sul suo mutex
  xpthread_mutex_lock(&a->c1->mutex_cond,__LINE__,__FILE__);
  a->c1->nletti++;
  //Segnalo che ho letto un numero
  xpthread_cond_broadcast(&a->c1->cond,__LINE__,__FILE__);
  //Tolgo il mutex
  xpthread_mutex_unlock(&a->c1->mutex_cond,__LINE__,__FILE__);
  pthread_exit(NULL); 
}

//Thread principale n di interi memorizzati e crea n thread
int main(int argc, char*argv[]){
  if((argc<3) || (argc>4)){perror("Si usa ./divisoriT infile outfile (n) "); exit(1);}
  int n=0;
  if(argc==4)
    n=atoi(argv[3]);
  char infile[20], outfile[20];
  strcpy(infile,argv[1]);//\\ poteva usare direttamente argv[1] e argv[2]
  strcpy(outfile,argv[2]);//\\ senza queste operazioni di copia che sono pericolose se argv[1] o [2] sono + lunghe di 19
  //Apro il file in lettura
  FILE *fin=xfopen(infile,"r",__LINE__,__FILE__);
  FILE *fout=xfopen(outfile,"w",__LINE__,__FILE__);
  int e;
  int n2=0;
  //Conto quanti numeri ci sono
  while(true){
    int x;
    e=fscanf(fin,"%d",&x);
    if(e==EOF) break;
    n2++;
  }
  //Se diverso da quello dato in input lo sovrascivo
  if(n!=n2) n=n2; //\\ questo non andava fatto 
  rewind(fin); //Torno all'inizio del file
  printf("N vale : %d\n",n);
  //Creo struct cond variable e la inizializzo
  cond_var c;
  c.nletti=0;
  xpthread_cond_init(&c.cond,NULL,__LINE__,__FILE__);
  xpthread_mutex_init(&c.mutex_cond,NULL,__LINE__,__FILE__);
  //Creo il mutex
  pthread_mutex_t mutex_thread = PTHREAD_MUTEX_INITIALIZER;
  //Creo n thread
  pthread_t t[n];
  dati arg[n];
  for(int i=0;i<n;i++){
    e=fscanf(fin,"%d",&arg[i].n);
    assert(e==1);
    arg[i].mutex_thread=&mutex_thread;
    arg[i].f=fout;
    arg[i].c1 = &c;
    xpthread_create(&t[i], NULL, tbody, (void *) &arg[i],__LINE__,__FILE__);
  }
  //Attesa sulla condition variable
  while(c.nletti < n){
    xpthread_cond_wait(&c.cond,&c.mutex_cond,__LINE__,__FILE__);
  }
  // join dei thread e calcolo risultato
  for(int i=0;i<n;i++) {
    e = pthread_join(t[i], NULL);
    if(e==0)
      fprintf(stderr,"Thread %d terminato\n",i);
    else 
      fprintf(stderr,"Errore join %d\n",e);
  }
  //Chiudo i file
  fclose(fin);
  fclose(fout);
  return 0;
}

bool primo(int n)
{
  int i;
  if(n<2) return false;
  if(n%2==0) {
    if(n==2)
      return true;
    else
      return false;
  }
  for (i=3; i*i<=n; i += 2) {
      if(n%i==0) {
          return false;
      }
  }
  return true;
}
