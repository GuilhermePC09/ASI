#ifndef CONTROLLER_H
#define CONTROLLER_H

#include <libvercors.h>

#define ADDR_OUT    0x1C0A
#define ADDR_IN    0x1C08
#define P_OUT (*((ioport int*)ADDR_OUT))
#define P_IN (*((ioport int*)ADDR_IN))

void modify_bit_in_address(ioport int *address, int bit_position, int bit_value);

void fermer_contacteur(void);

void ouvrir_contacteur(void);

void allumer_led(void);

void eteindre_led(void);

void inverser_led(void);

int est_bouton_appuye(void);

void impulsion_maintenant (void);

void inverser_led_pause (void);

#endif
