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
	lcd_open();
	if (!AUDIO_Init()){ //todo hier naar kijken
		printf("Audio Init fail!\n");
		lcd_display(("Audio Init fail!\n\n"));
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

	hFat = Fat_Mount(FAT_SD_CARD, 0);				//sd kaart mounten
	if (hFat){
		if (build_wave_play_list(hFat)){			//afspeellijst maken van alle .wav files
			bSdacrdReady = TRUE;
		}else{
			printf("There is no wave file in the root directory of SD card.\n");
			lcd_display(("No Wave Files.\n\n"));
		}
	}else{
		printf("SD card mount fail.\n");
		lcd_display(("SD card mount fail.\n\n"));
	}

	printf("TaskReadSD done\n");
	OSTaskDel(OS_PRIO_SELF);
}

//Reageerd op user input
void TaskKeyHandler(void * pdata)
{
	INT8U err;
	bool lcdPrint = FALSE; 	//variabele om te kijken of "Awaiting input" al is afgedrukt

	while(1)
	{
		//als bSdacrdReady FALSE is maken we TaskReadSD aan
		if(!bSdacrdReady) OSTaskCreate(TaskReadSD, NULL, (void *)&TaskReadSDStack[TASK_STACKSIZE-1], TaskReadSD_PRIORITY);

		if(!lcdPrint){
			printf("Awating input\n");
			lcd_display(("\rAwating input\n\n"));
			lcdPrint = TRUE;
		}

		int songNummer = getButtonId(mtc2->x1, mtc2->y1);
		while(mtc2->TouchNum && bSdacrdReady) {
			if(!waveplay_execute(songNummer)){
				printf("stop playing\n");
				bSdacrdReady = FALSE;
				lcdPrint = FALSE;
			}
			handle_key();
		}
	}
}
