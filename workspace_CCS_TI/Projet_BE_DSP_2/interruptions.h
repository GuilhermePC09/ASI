#ifndef CONTROLLER_H
#define CONTROLLER_H

#include <libvercors.h>

#define IER_0	0x00
#define INTER_AUTH	(*((int*) IER_0))

void autoriser_interruption_timer (void);
void autoriser_interruption_can (void);
void ecouter_les_interruptions (void);
void  isr_timer (void);
void inverse(int pin);

#endif