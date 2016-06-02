#ifndef __AUDIO_F_H__
#define __AUDIO_F_H__

#include "custom_type.h"
#include ".\terasic_lib\terasic_includes.h"

// Functie prototypes
void wait_sdcard_insert(void);
bool is_supporrted_sample_rate(int sample_rate);
int build_wave_play_list(FAT_HANDLE hFat);
bool waveplay_start(int songnummer);
bool waveplay_execute(int songnummer);
void handle_key();
bool Fat_Test(FAT_HANDLE hFat, char *pDumpFile);

// LCD Display config
#define LCD_DISPLAY
#define SUPPORT_PLAY_MODE
#define xENABLE_DEBOUNCE

// Volume config
#define HW_MAX_VOL     127
#define HW_MIN_VOL     47
#define HW_DEFAULT_VOL  120

// Audio structure config
#define FILENAME_LEN    32
#define WAVE_BUF_SIZE  512  // do not chagne this constant (FIFO: 4*128 byte)

// Globale variabelen
typedef struct{
    FAT_FILE_HANDLE hFile;
    alt_u8          szBuf[WAVE_BUF_SIZE];  // one sector size of sd-card
    alt_u32         uWavePlayIndex;
    alt_u32         uWaveReadPos;
    alt_u32         uWavePlayPos;
    alt_u32         uWaveMaxPlayPos;
    char szFilename[FILENAME_LEN];
    bool            readOk;

}PLAYWAVE_CONTEXT;

#define MAX_SONGS 28
static PLAYWAVE_CONTEXT gWavePlay[MAX_SONGS + 1];
FAT_HANDLE hFat;
alt_u8 volume;
int songAmount;                 //aantal wav files op sd card
bool songRecording = FALSE;     //bepaald of er een recording is
bool playingRecording = FALSE;  //bepaald of er een recording aan het spelen is
bool busyRecording = FALSE;     //bepaald of er een recoding opgenomen wordt.

#endif
