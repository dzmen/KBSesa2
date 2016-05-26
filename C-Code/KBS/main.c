#include "audio_f.c"
#include "main.h"

// UPLOAD COMMAND: nios2-download -g KBS.elf && nios2-terminal

/* The main function creates two task and starts multi-tasking */
int main(void)
{
	/* Semafoor init*/
	SEM_bSdacrdReady = OSSemCreate(1);

	/* APP init */
	graphic_init();
	if (!AUDIO_Init()){ //todo hier naar kijken
		printf("Audio Init fail!\n");
		drawMessage("Audio Init fail!");
		OSTaskDel(OS_PRIO_SELF);
	}

	memset(&gWavePlay, 0, sizeof(gWavePlay));
	memset(&gWavePlay[MAX_SONGS + 1], 0, sizeof(gWavePlay[MAX_SONGS + 1]));
	volume = HW_DEFAULT_VOL;
	AUDIO_SetLineOutVol(volume, volume);

	/* Task init*/
	OSTaskCreate(TaskKeyHandler, NULL, (void *)&TaskKeyHandlerStack[TASK_STACKSIZE-1], TaskKeyHandler_PRIORITY);

	OSStart();
	return 0;
}

/* Lees de sd kaart in*/
void TaskReadSD(void* pdata)
{
	printf("TaskReadSD created\n");
	wait_sdcard_insert();							//wacht totdat er een sd kaart is ingevoegd
	drawSdcardBlank();
	hFat = Fat_Mount(FAT_SD_CARD, 0);				//sd kaart mounten
	if (hFat){
		if (build_wave_play_list(hFat)){			//afspeellijst maken van alle .wav files
			bSdacrdReady = TRUE;
			drawButtonsRandom(gWavePlayList.nFileNum);
			drawRecord();
		}else{
			printf("There is no wave file in the root directory of SD card.\n");
			drawMessage("No Wave Files.");
		}
	}else{
		printf("SD card mount fail.\n");
		drawMessage("SD card mount fail.");
	}

	printf("TaskReadSD done\n");
	OSTaskDel(OS_PRIO_SELF);
}

//Reageerd op user input
void TaskKeyHandler(void * pdata)
{
	INT8U err;
	int songNummer;
	printf("Task keyhandler start\n");

	while(1)
	{
		//als bSdacrdReady FALSE is maken we TaskReadSD aan
		if(!bSdacrdReady) OSTaskCreate(TaskReadSD, NULL, (void *)&TaskReadSDStack[TASK_STACKSIZE-1], TaskReadSD_PRIORITY);
		else{
			songNummer = getButtonId(mtc2->x1, mtc2->y1);
			while(mtc2->TouchNum && bSdacrdReady && songNummer != 111) {
				songNummer = getButtonId(mtc2->x1, mtc2->y1);
				if(!waveplay_execute(songNummer)){
					printf("stop playing\n");
					bSdacrdReady = FALSE;
					drawButtonsGrey();
				}
				handle_key();
			}
			if(recordTouched(mtc2->x1, mtc2->y1) && mtc2->TouchNum){
				if(busyRecording){
					busyRecording = FALSE;
					songRecording = TRUE;
					drawRecord();
					drawPlay();
				}else{
					busyRecording = TRUE;
					songRecording = FALSE;
					drawRecording();
					drawBlank();
				}
			}
			if(playTouched(mtc2->x1, mtc2->y1) && songRecording && mtc2->TouchNum){
				if(playingRecording){
					playingRecording = FALSE;
					drawStop();
				} else{
					playingRecording = TRUE;
					drawPlay();
				}
			}
			handle_key();
			OSTimeDlyHMSM(0,0,0,50);
		}
	}
}
