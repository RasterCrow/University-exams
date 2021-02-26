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

#define Buf_size 2

int main(int argc, char*argv[]){
  if((argc<3)){perror("Si usa ./divisoriT infile outfile "); exit(1);}
  char infile[20], outfile[20];
  strcpy(infile,argv[1]);
  strcpy(outfile,argv[2]);
  int p=1;
  int e,n=0;
  //Apro il file in lettura
  FILE *fin=xfopen(infile,"r",__LINE__,__FILE__);
  FILE *fout = xfopen(outfile,"w",__LINE__,__FILE__);
  //Conto quanti numeri ci sono
  while(true){
    int x;
    e=fscanf(fin,"%d",&x);
    if(e==EOF) break;
    n++;
  }
  // alloca i semafori nella shared memory 
  int shmid = xshmget(IPC_PRIVATE,2*sizeof(sem_t),0600,__LINE__,__FILE__);
  sem_t *a = (sem_t *) xshmat(shmid,NULL,0,__LINE__,__FILE__);
  sem_t *free_slots = &a[0]; 
  sem_t *data_items = &a[1]; 
  // inizializza i semafori, il secondo argomento !=0 permette di condividerli tra processi
  xsem_init(free_slots,1,Buf_size,__LINE__,__FILE__);
  xsem_init(data_items,1,0,__LINE__,__FILE__);
  // inizializza shared memory per contenere buffer, somma, quanti e cindex
  int shmid2 = xshmget(IPC_PRIVATE,(2*p+Buf_size)*sizeof(int),0600,__LINE__,__FILE__);
  int *buffer = (int *) xshmat(shmid2,NULL,0,__LINE__,__FILE__);  
  int *somma = buffer + Buf_size; //\\ tutti uesti non servivano, bastava il buffer
  int *quanti = somma + p;
  int *cindex = quanti + p;
  *cindex = 0;
  int pindex=0;
  int primi[n];
  //  creo i processi consumatori
  if(xfork(__LINE__,__FILE__)==0) {
    //Processo figlio
    int x;
    
    int j=0;
    while(true) { 
      xsem_wait(data_items,__LINE__,__FILE__);
      x = buffer[*cindex];
      printf("%d\n",x);
      *cindex = (*cindex+1)%Buf_size;  
      xsem_post(free_slots,__LINE__,__FILE__);
      if(x<0) break;
      
      //Calcolo i suoi primi e li metto in un array secondario
      for(int i=2;i<x;i++)//\\ ci voleva j=0
        if(x%i == 0)
          if(primo(i))
            primi[j++]=i;
      //Scrivo sul file il numero n
      fprintf(fout,"%d :",x);
      //Scrivo sul file i suoi divisori
      for(int i=0;i<j;i++){
        fprintf(fout," %d",primi[i]);
      }
      //Infine vado a capo
      fprintf(fout,"\n");
    }
    // detach memoria condivisa
    xshmdt(a,__LINE__,__FILE__);
    xshmdt(buffer,__LINE__,__FILE__);
      fclose(fout);
    exit(0);
  }
  rewind(fin);
  //Processo padre
  int x;
  while(true){
    e = fscanf(fin,"%d", &x);
    if(e!=1) break; // se il valore e' letto correttamente e==1
       // metto n nel buffer
    xsem_wait(free_slots,__LINE__,__FILE__);
    buffer[pindex] = x;
    pindex = (pindex+1)%Buf_size;
    xsem_post(data_items,__LINE__,__FILE__);
  }
  // segnalo terminazione ai consumatori
  xsem_wait(free_slots,__LINE__,__FILE__);
    buffer[pindex] = -1;
    pindex = (pindex+1)%Buf_size;
    xsem_post(data_items,__LINE__,__FILE__);
  // aspetta terminazione figli
  xwait(NULL,__LINE__,__FILE__);
  fclose(fin);

  return 0;
}
