/*
 * graphic_f.h
 *
 *  Created on: 17 mei 2016
 *      Author: danny
 */

#ifndef GRAPHIC_F_H_
#define GRAPHIC_F_H_

#include ".\terasic_lib\terasic_includes.h"

/* Touch Display config */
#define FR_FRAME  (SDRAM_BASE + FRAME_WIDTH*FRAME_HEIGHT*4)
#define FRAME_WIDTH  800
#define FRAME_HEIGHT 480

//Een pointer voor de touchscreen informatie
MTC2_INFO *pTouch;

//Dit is een stuc met daarin de informatie over het lcd scherm (niet de touchscreen)
VIP_FRAME_READER *pReader;

/* Functie prototypes */
void graphic_init();
void drawButtonsGrey();
void drawButtonsRandom(int songs);
void drawRecord();
void drawRecording();
void drawPlay();
void drawStop();
void drawBlank();
void drawMessage(char message[]);
void drawSdcardBlank();
int getButtonId(int x, int y);
bool recordTouched(int x, int y);
bool playTouched(int x, int y);
int getTouched();

#endif
