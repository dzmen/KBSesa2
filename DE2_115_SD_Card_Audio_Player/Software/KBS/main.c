#include "includes.h"
#include "definitions.h"
#include "functions.c"

// UPLOAD COMMAND: nios2-download -g KBS.elf && nios2-terminal

/* Definition of Task Stacks */
#define   TASK_STACKSIZE       2048
OS_STK    TaskReadSDStack[TASK_STACKSIZE];
OS_STK    TaskPlayMusicStack[TASK_STACKSIZE];

/* Definition of Task Priorities */
#define TaskReadSD_PRIORITY      4
#define TaskPlayMusic_PRIORITY      5

/* Semafoor definition*/
OS_EVENT * play_music;

/* Function prototypes */
void TaskReadSD(void* pdata);
void TaskPlayMusic(void* pdata);

/* The main function creates two task and starts multi-tasking */
int main(void)
{
	play_music = OSSemCreate(0);

	OSTaskCreate(TaskReadSD, NULL, (void *)&TaskReadSDStack[TASK_STACKSIZE-1], TaskReadSD_PRIORITY);
	//OSTaskCreate(TaskPlayMusic, NULL, (void *)&TaskPlayMusicStack[TASK_STACKSIZE-1], TaskPlayMusic_PRIORITY);

	OSStart();
	return 0;
}

/* Does something */
void TaskReadSD(void* pdata)
{
	INT8U err;
    int nPlayIndex;
    bool bSdacrdReady = FALSE;
    alt_u8 szWaveFile[FILENAME_LEN];
    lcd_open();
    if (!AUDIO_Init()){
        printf("Audio Init fail!\n");
        lcd_display(("Audio Init fail!\n\n"));
        OSTaskDel(OS_PRIO_SELF);
    }

    memset(&gWavePlay, 0, sizeof(gWavePlay));
    gWavePlay.nVolume = HW_DEFAULT_VOL;
    AUDIO_SetLineOutVol(gWavePlay.nVolume, gWavePlay.nVolume);

    while(1){

        // check SD card
        wait_sdcard_insert();

        // Mount SD-CARD
        hFat = Fat_Mount(FAT_SD_CARD, 0);
        if (!hFat){
            printf("SD card mount fail.\n");
            lcd_display(("SD card mount fail.\n\n"));
        }
        else{
           if (build_wave_play_list(hFat) == 0){
        	   printf("There is no wave file in the root directory of SD card.\n");
            	lcd_display(("No Wave Files.\n\n"));
            }else{
            	bSdacrdReady = TRUE;
            }
        }

        nPlayIndex = 0;
        while(bSdacrdReady){
            // find a wave file
            bool bPlayDone = FALSE;
            strcpy(szWaveFile, gWavePlayList.szFilename[nPlayIndex]);
            printf("Play Song:%s\r\n", szWaveFile);
            if (!waveplay_start(szWaveFile)){
                printf("waveplay_start error\r\n");
                lcd_display("Play Error.\n\n");
                bSdacrdReady = FALSE;
            }
            update_status();
            while(!bPlayDone && bSdacrdReady){
                bool bEndOfFile = FALSE;
                // play wave file
                if (!waveplay_execute(&bEndOfFile)){
                    printf("waveplay_execute error\r\n");
                    lcd_display("Play Error.\n\n");
                    bSdacrdReady = FALSE;
                }

                // handle key event
                handle_key();
                if (bSdacrdReady && (bEndOfFile)){
                    bool bNextSong = FALSE;
                    bool bLastSong = FALSE;

                    if(bEndOfFile) bNextSong = TRUE;
                    // check whether in REPEAT mode
                    if (gWavePlay.bRepeatMode){
                        bNextSong = FALSE;  // in repeat mode
                        bLastSong = FALSE;
                    }
                    if (bNextSong){  // index update for next song
                        nPlayIndex++;
                        if (nPlayIndex >= gWavePlayList.nFileNum)
                            nPlayIndex = 0;
                    }
                    if (bLastSong){  // index update for last song
                        nPlayIndex--;
                        if (nPlayIndex < 0)
                            nPlayIndex = gWavePlayList.nFileNum-1;
                    }
                    bPlayDone = TRUE;
                }
            }  // while(!bPlayNextSong && bSdacrdReady)
            waveplay_stop();
        }  // while(bSdacrdReady)
  } // while (1)
}

/* Does something */
void TaskPlayMusic(void* pdata)
{
	INT8U err;
	while (1)
	{
		//OSSemPend(play_music,0,&err);

		printf("Hello from TaskPlayMusic\n");
		OSTimeDlyHMSM(0, 0, 3, 0);
	}
}

