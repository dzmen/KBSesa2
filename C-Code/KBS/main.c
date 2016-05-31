#include "audio_f.c"
#include "main.h"

// UPLOAD COMMAND: nios2-download -g KBS.elf && nios2-terminal

int main(void)
{
	// Semafoor init
	SEM_sdCardReady = OSSemCreate(1);
	SEM_recording = OSSemCreate(1);

	// APP init
	graphic_init();
	if (!AUDIO_Init()){
		printf("Audio Init fail!\n");
		drawMessage("Audio Init fail!");
		OSTaskDel(OS_PRIO_SELF);
	}

	//
	memset(&gWavePlay[MAX_SONGS + 1], 0, sizeof(gWavePlay[MAX_SONGS + 1]));
	memset(&recordingPlaylist[MAX_RECORDING], 0, sizeof(recordingPlaylist[MAX_RECORDING]));
	volume = HW_DEFAULT_VOL;

	// Task init
	OSTaskCreate(TaskKeyHandler, NULL, (void *)&TaskKeyHandlerStack[TASK_STACKSIZE-1], TaskKeyHandler_PRIORITY);

	OSStart();
	return 0;
}

//Lees de sd kaart in
void TaskReadSD(void* pdata)
{
	printf("TaskReadSD created\n");
	wait_sdcard_insert();							//wacht totdat er een sd kaart is ingevoegd
	drawSdcardBlank();
	hFat = Fat_Mount(FAT_SD_CARD, 0);				//sd kaart mounten
	if (hFat){
		if (build_wave_play_list(hFat)){			//afspeellijst maken van alle .wav files
			sdCardReady = TRUE;
			drawButtonsRandom(songAmount);
			drawRecord();
			drawVolume(volume);
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
	int songNummer = 111;
	int count = 0;
	printf("Task keyhandler start\n");

	while(1)
	{
		if(!sdCardReady) OSTaskCreate(TaskReadSD, NULL, (void *)&TaskReadSDStack[TASK_STACKSIZE-1], TaskReadSD_PRIORITY);
		else{
			OSSemPend(SEM_recording,0,&err);
			if(mtc2->TouchNum)songNummer = getButtonId(mtc2->x1, mtc2->y1);
			if(songNummer < songAmount && songNummer != 111){
				waveplay_start(songNummer);
				int ticks = 0;
				while(mtc2->TouchNum && sdCardReady && songNummer != 111) {
					songNummer = getButtonId(mtc2->x1, mtc2->y1);
					if(!waveplay_execute(songNummer)){
						printf("stop playing\n");
						sdCardReady = FALSE;
						drawButtonsGrey();
					}
					handle_key();
					ticks++;
				}
				if(busyRecording){
					recordingPlaylist[count].songnummer = songNummer;
					recordingPlaylist[count].playticks = ticks;
					count++;
				}
				songNummer = 111;
			}
			err = OSSemPost(SEM_recording);
			if(recordTouched(mtc2->x1, mtc2->y1) && mtc2->TouchNum){
				OSTimeDlyHMSM(0,0,0,50);
				if(!busyRecording){
					busyRecording = TRUE;
					songRecording = FALSE;
					int i;
					for (i = 0; i < MAX_RECORDING; i++) {
						recordingPlaylist[i].playticks = NULL;
						recordingPlaylist[i].songnummer= NULL;
					}
					count = 0;
					drawRecording();
					drawBlank();
				} else{
					busyRecording = FALSE;
					songRecording = TRUE;
					drawRecord();
					drawPlay();
				}
			}
			if(playTouched(mtc2->x1, mtc2->y1) && songRecording && mtc2->TouchNum){
				if(!playingRecording){
					OSTimeDlyHMSM(0,0,0,100);
					OSSemPend(SEM_recording,0,&err);
					//start task playing recording
					OSTaskCreate(TaskPlayRecording, NULL, (void *)&TaskPlayRecordingStack[TASK_STACKSIZE-1], TaskPlayRecording_PRIORITY);
				}
			}
			handle_key();
			OSTimeDlyHMSM(0,0,0,50);
		}
	}
}

//Speelt de afspeellijst af
void TaskPlayRecording(void * pdata)
{
	printf("TaskPlayRecording start\n");
	INT8U err;
	playingRecording = TRUE;

	drawStop();
	resetTouchCoordinates();

	int i;
	for (i = 0; i < MAX_RECORDING; i++) { //todo nog kijken tot hoeveel is ingedrukt
		printf("Playing song: %d\n", recordingPlaylist[i].songnummer);
		int j;
		for (j = 0; j <= recordingPlaylist[i].playticks; j++) {
			//if delay else exe
			if(!waveplay_execute(recordingPlaylist[i].songnummer)){
				playingRecording = FALSE;
			}
			handle_key();
			if(playTouched(mtc2->x1, mtc2->y1)) playingRecording = FALSE;
		}
		if(playTouched(mtc2->x1, mtc2->y1)) playingRecording = FALSE;
	}
		playingRecording = FALSE;

	drawPlay();
	printf("TaskPlayRecording end\n");
	err = OSSemPost(SEM_recording);
	OSTaskDel(OS_PRIO_SELF);
}
