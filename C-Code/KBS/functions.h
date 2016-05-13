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
void lcd_open(void);
void lcd_display(char *pText);
void wait_sdcard_insert(void);
bool is_supporrted_sample_rate(int sample_rate);
int build_wave_play_list(FAT_HANDLE hFat);
bool waveplay_start(char *pFilename);
bool waveplay_execute(bool *bEOF);
void handle_key();
bool Fat_Test(FAT_HANDLE hFat, char *pDumpFile);

#endif

