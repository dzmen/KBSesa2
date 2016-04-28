#ifndef __DEFINITIONS_H__
#define __DEFINITIONS_H__

//===== Terasic includes

#include ".\terasic_lib\terasic_includes.h"

//===== display config =====

#define LCD_DISPLAY
#define SUPPORT_PLAY_MODE
#define xENABLE_DEBOUNCE

//===== constance definition =====
#define HW_MAX_VOL     127
#define HW_MIN_VOL     47
#define HW_DEFAULT_VOL  80

//===== structure definition =====

// return number of wave file
#define MAX_FILE_NUM    128
#define FILENAME_LEN    32

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

#endif