//Alexandru Stefan Andries
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

#define SIZE 100

int *lunghezze(char s[], int *m);
int main(int argc,char*argv[])
{
    if(argc!=2){
        printf("Non si usa cosi");
        return 1;
    }
    int dim;
    //\\ non andava allocato qui 
    int*array=(int*)malloc(SIZE*sizeof(int));
    array=lunghezze(argv[1],&dim);
    for(int i=0;i<dim;i++)// stampa l'array
        printf("%d ",array[i]);
    return 0;
}

int *lunghezze(char s[], int*m)
{
    int lun=0,*array,i=0;
    char frase[SIZE],*r;
    array=(int*)malloc(SIZE*sizeof(int));
    //\\ manca verifica malloc e la dimesnione e' fissa a 100
    FILE *f=fopen(s,"r");
    if(f== NULL)
    {
        *m=i;
        puts("NULL");//SE non apre il file stampa null e finisce la funzione.
        return NULL;
    }
    while(true)
    {
        r=fgets(frase,SIZE,f);
        if(r==NULL)
            break;
        lun=strlen(r);
        //Nel caso del'esempio nella consegna su uno, c'è uno spazio in più, quindi il risultato esce 5
        lun=lun-1;
        array[i++]=lun;
    }
    *m=i;
    return array;
}
