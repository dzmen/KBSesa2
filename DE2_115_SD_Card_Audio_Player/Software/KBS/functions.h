/*
 * functions.h
 *
 *  Created on: Apr 20, 2016
 *      Author: Wilco
 */

#ifndef __FUNCTIONS_H__
#define __FUNCTIONS_H__

#include "definitions.h"

typedef struct{
    int nFileNum;
    char szFilename[MAX_FILE_NUM][FILENAME_LEN];
}WAVE_PLAY_LIST;


static WAVE_PLAY_LIST gWavePlayList;
#define WAVE_BUF_SIZE  512  // do not chagne this constant (FIFO: 4*128 byte)
typedef struct{
    FAT_FILE_HANDLE hFile;
    alt_u8          szBuf[WAVE_BUF_SIZE];  // one sector size of sd-card
    alt_u32         uWavePlayIndex;
    alt_u32         uWaveReadPos;
    alt_u32         uWavePlayPos;
    alt_u32         uWaveMaxPlayPos;
    char szFilename[FILENAME_LEN];
    alt_u8          nVolume;
    bool            bRepeatMode;
}PLAYWAVE_CONTEXT;

static PLAYWAVE_CONTEXT gWavePlay;// = {{0},{0}, HW_DEFAULT_VOL, {0}, 0, 0, 0};
static FAT_HANDLE hFat;

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

