//Alexandru Stefan Andries

// es1: manca gestione fine stringa stringhe e verifica malloc
// es2: errore gestione file lunghi
// voto 22: voto primo esonero 24 quiz 7.5
// voto finale 24


#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

#define SIZE 100


char*prefissi(char s[]);
int main(int argc,char*argv[])
{
    if(argc!=2){
        printf("Non si usa cosi");
        return 1;
    }
    char*array=(char*)malloc(SIZE*sizeof(char));
    array=prefissi(argv[1]);
    printf("%s\n",array);
    return 0;

}
char*prefissi(char s[])
{
    char *stringa,*output;
    int dim=strlen(s),lun=0;
    stringa=(char*)malloc(SIZE*sizeof(char));
    output=(char*)malloc(SIZE*sizeof(char));
    //\\ manca verifica malloc
    for(int i=0;i<dim;i++)
    {
        stringa[i]=s[i];//\\ ci vuole lo 0 in fondo 
        lun=strlen(stringa)-1;
        if(i==dim-1){ // se siamo nell'ultima lettera non aggiunge più spazi.
            output=(strcat(output,stringa));
            break;}
        stringa[lun+1]=' ';
        output=(strcat(output,stringa));
    }
    return output;
}
