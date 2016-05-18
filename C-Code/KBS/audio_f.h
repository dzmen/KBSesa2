/*
 * functions.h
 *
 *  Created on: Apr 20, 2016
 *      Author: Wilco
 */

#ifndef __AUDIO_F_H__
#define __AUDIO_F_H__

#include "main.h"

//===== function prototype =====
void update_status(int songnummer);
void lcd_open(void);
void lcd_display(char *pText);
void wait_sdcard_insert(void);
bool is_supporrted_sample_rate(int sample_rate);
int build_wave_play_list(FAT_HANDLE hFat);
bool waveplay_start(int songnummer);
bool waveplay_execute(bool *bEOF,int songNummer);
void handle_key();
bool Fat_Test(FAT_HANDLE hFat, char *pDumpFile);

#endif

