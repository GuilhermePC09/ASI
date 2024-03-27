/**********************************************/
/* Auteur de la version initiale : E. Escande */
/* modification : Equipe pédagogique ENSE3    */
/* Auteur de la dernière version : G. Piffer, T.Janssens */
/**********************************************/

#include <libvercors.h>
#include "driver_io.h"

void main (void) {
    initialisation_dsp();

    while(1) {
    	inverser_led();
    }

// other codes
/*
    	long int i = 0;
        int bouton_appuye = est_bouton_appuye();

        if(bouton_appuye == 1){
            fermer_contacteur();
        }
        else{
            ouvrir_contacteur();
        }

        inverser_led();
        for(i = 0; i < 3500000; i++){

        }
*/

// Avec l'optimization à 3 nous avons une vitesse plus rapide, parce que il n'utilise pas le for;
/*
    while(1){
        *((ioport int*)0x1C0A) |= (1<<0);
        *((ioport int*)0x1C0A) &=~(1<<0);
    }
*/


}


