#ifndef __GRAPHIC_F_H__
#define __GRAPHIC_F_H__

#include ".\terasic_lib\terasic_includes.h"

// Touch Display config
#define FR_FRAME  (SDRAM_BASE + FRAME_WIDTH*FRAME_HEIGHT*4)
#define FRAME_WIDTH  800
#define FRAME_HEIGHT 480

// Functie prototypes
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
void drawVolume(alt_u8 volume);
int getButtonId(int x, int y);
bool recordTouched(int x, int y);
bool playTouched(int x, int y);
void resetTouchCoordinates();

// Globale variabelen
MTC2_INFO *pTouch;  //Een pointer voor de touchscreen informatie

//Dit is een stuct met daarin de informatie over het lcd scherm (niet de touchscreen)
VIP_FRAME_READER *pReader;

#endif
