/*
 * graphic_f.h
 *
 *  Created on: 17 mei 2016
 *      Author: danny
 */

#ifndef GRAPHIC_F_H_
#define GRAPHIC_F_H_

//===== Terasic includes

#include ".\terasic_lib\terasic_includes.h"

//==== display definition ========

#define FR_FRAME  (SDRAM_BASE + FRAME_WIDTH*FRAME_HEIGHT*4)

#define FRAME_WIDTH  800
#define FRAME_HEIGHT 480

//Een pointer voor de touchscreen informatie
MTC2_INFO *pTouch;

//Dit is een stuc met daarin de informatie over het lcd scherm (niet de touchscreen)
VIP_FRAME_READER *pReader;

void graphic_init();
void drawbutton(int id);
int getButtonId(int x, int y);

#endif /* GRAPHIC_F_H_ */
