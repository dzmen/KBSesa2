/*
 * functions.h
 *
 *  Created on: Apr 20, 2016
 *      Author: Wilco
 */

#ifndef __FUNCTIONS_H__
#define __FUNCTIONS_H__

#include "definitions.h"

//===== function prototype =====
void update_status(void);
void wait_sdcard_insert(void);
int build_wave_play_list(FAT_HANDLE hFat);
void handle_key();
bool waveplay_start(char *pFilename);
bool waveplay_execute(bool *bEOF);
void lcd_open(void);
void lcd_display(char *pText);
bool Fat_Test(FAT_HANDLE hFat, char *pDumpFile);

#endif

