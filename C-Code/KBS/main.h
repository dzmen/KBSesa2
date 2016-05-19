#ifndef __MAIN_H__
#define __MAIN_H__
#include "includes.h"
#include "custom_type.h"

/* Task Stacks definitie*/
#define   TASK_STACKSIZE       2048
#define   MAX_SONGS 28
OS_STK    TaskReadSDStack[TASK_STACKSIZE];
OS_STK    TaskKeyHandlerStack[TASK_STACKSIZE];
//OS_STK    TaskPlayMusicStack[TASK_STACKSIZE];
OS_STK    TaskPlaySongStack[MAX_SONGS + 1][TASK_STACKSIZE];

/* Task Priorities definitie*/
#define TaskReadSD_PRIORITY      	4
#define TaskKeyHandler_PRIORITY     5
//#define TaskPlayMusic_PRIORITY      9
//#define TaskPlaySong_PRIORITY      	10

/* Semafoor definitie*/
OS_EVENT * SEM_nPlayIndex;
OS_EVENT * SEM_bSdacrdReady;
OS_EVENT * SEM_szWaveFile;
OS_EVENT * SEM_playing;

/* Globale variabelen*/ //todo variabelen commenten en nalopen op gebruik in fucntions
int songPrio = 10;
int nPlayIndex;					//momenteel niet in gebruik
bool bSdacrdReady = FALSE;		//variabele die bij houdt of de sd kaart klaar is voor gebruik
//alt_u8 szWaveFile[FILENAME_LEN]; //variabele die de naam van een .wav bestand bewaart

/* Functie prototypes */
void TaskReadSD(void* pdata);
//void TaskPlayMusic(void* pdata);
void TaskKeyHandler(void* pdata);
void TaskPlaySong(void* pdata);

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
    bool            readOk;

}PLAYWAVE_CONTEXT;

alt_u8 volume;
bool repeatMode;

static PLAYWAVE_CONTEXT gWavePlay[MAX_SONGS + 1];
static FAT_HANDLE hFat;

#endif
