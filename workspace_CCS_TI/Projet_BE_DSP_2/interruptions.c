#include <libvercors.h>

#define IER_0	0x00
#define SARCTRL 	(*((ioport int*) 0x7012))
#define SARDATA 	(*((ioport int*) 0x7014))
#define INTER_AUTH	(*((int*) IER_0))
#define TIMER_FLAG 	(*((ioport int*) 0x1C14))
#define POINT_TEST	(*((ioport int*) 0x1C0A))


void autoriser_interruption_timer (void) {
	INTER_AUTH |= (1 << 4);
}

void autoriser_interruption_can (void) {
	INTER_AUTH |= (1 << 13);
}

void declencher_echantillonnage_can (void) {
	SARCTRL |= (1 << 15);
	SARCTRL &= ~(1 << 11);
	SARCTRL |= (1 << 10);
}

int echantillon_est_disponible (void) {
	int sarData = SARDATA;
	int bit = (sarData >> 15);

	if(bit == 0){
		return 1;//true
	}
	else {
		return 0;//false
	}
}

int recuperer_echantillon_can (void) {
	int sarData = SARDATA;
	int mask = 0x03FF;

	return sarData & mask;
}

void ecouter_les_interruptions (void) {
	asm(" BCLR INTM");
}

void sortir_sur_cna(void) {

}

void inverse(int pin) {
    int addr = 0x1C0A;
    int data = (*((ioport int*) addr));
    int mask = (1 << pin);
    int bit = (data >> pin) & 1;

    if (bit == 0) {
        data |= mask;
    } else {
        data &= ~mask;
    }
    *((ioport int*) addr) = data;
}

float mesurer_courant(int mesure){
	int size = 1024;
	float minValue = -20.0;
	float maxValue = 20.0;

	return (maxValue-minValue)*mesure/size + (minValue);
}

interrupt void  isr_timer (void) {
	TIMER_FLAG |= (1 << 0);

	declencher_echantillonnage_can();

//	POINT_TEST ^= (1 << 9);
//	POINT_TEST |= (1 << 9);
//	POINT_TEST &= ~(1 << 9);
//	inverse(9);
}

interrupt void isr_can (void) {
	int result;
	float courant;
	if (echantillon_est_disponible()){
		result = recuperer_echantillon_can();
		courant = mesurer_courant(result);
	}

}
