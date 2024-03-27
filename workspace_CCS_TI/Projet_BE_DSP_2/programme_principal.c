/**********************************************/
/* Auteur de la version initiale : E. Escande */
/* modification : Equipe pédagogique ENSE3    */
/**********************************************/

#include <libvercors.h>
#include "interruptions.h"

#define POINT_TEST	(*((ioport int*) 0x1C0A))

void main (void) {
	initialisation_dsp();

	autoriser_interruption_timer();
	autoriser_interruption_can();
	declencher_echantillonnage_can();
	ecouter_les_interruptions();

	while (1) {
//		inverse(10);
	}
}
