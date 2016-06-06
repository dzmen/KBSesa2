#include "audio_f.c"
#include "main.h"

// UPLOAD COMMAND: nios2-download -g KBS.elf && nios2-terminal

int main(void)
{
	// Semafoor init
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
			drawButtonsColor(songAmount);
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
	int pauseTicks = 0;
	printf("Task keyhandler start\n");

	while(1)
	{
		if(!sdCardReady) OSTaskCreate(TaskReadSD, NULL, (void *)&TaskReadSDStack[TASK_STACKSIZE-1], TaskReadSD_PRIORITY);
		else{
			OSSemPend(SEM_recording,0,&err);
			//als er touch input is refresh dan songNummer
			if(mtc2->TouchNum)songNummer = getButtonId(mtc2->x1, mtc2->y1);
			//als er tijdens opnemen geen muziekknop wordt ingedrukt (songNummer is dan 111)
			if(songNummer == 111 && busyRecording){
				pauseTicks++;
			}else if(songNummer < songAmount){
				//als er weer een muziekknop wordt ingedrukt en er is een pauze geweest,
				// de pauze toevoegen aan recordingPlaylist
				if(pauseTicks){
					recordingPlaylist[count].songnummer = 111;
					recordingPlaylist[count].playticks = pauseTicks;
					count++;
					pauseTicks = 0;
				}
				//muziekbestand initialiseren
				waveplay_start(songNummer);
				int ticks = 0;
				//loopen totdat een muziekknop niet meer wordt ingedrukt,
				// er een fout is met afspelen of songNummer 111 is
				while(mtc2->TouchNum && sdCardReady && songNummer != 111) {
					songNummer = getButtonId(mtc2->x1, mtc2->y1);
					//muziek sample afspelen
					if(!waveplay_execute(songNummer)){
						printf("stop playing\n");
						sdCardReady = FALSE;
						drawButtonsGrey();
					}
					//volume regeling
					handle_key();
					ticks++;
				}
				//als er wordt opgenomen dan muziekbestand met speeltijd toevoegen aan recordingPlaylist
				if(busyRecording){
					recordingPlaylist[count].songnummer = songNummer;
					recordingPlaylist[count].playticks = ticks;
					count++;
				}
				//songNummer reset
				songNummer = 111;
			}
			err = OSSemPost(SEM_recording);

			//als de record / recording button wordt ingedrukt
			if(recordTouched(mtc2->x1, mtc2->y1) && mtc2->TouchNum){
				//delay als debounce
				OSTimeDlyHMSM(0,0,0,50);
				if(!busyRecording){
					busyRecording = TRUE;
					songRecording = FALSE;
					//recordingPlaylist resetten
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
			//als de play / stop button wordt ingedrukt en er data is in recordingPlaylist
			if(playTouched(mtc2->x1, mtc2->y1) && songRecording && mtc2->TouchNum){
				if(!playingRecording){
					//delay als debounce
					OSTimeDlyHMSM(0,0,0,50);
					OSSemPend(SEM_recording,0,&err);
					OSTaskCreate(TaskPlayRecording, NULL, (void *)&TaskPlayRecordingStack[TASK_STACKSIZE-1], TaskPlayRecording_PRIORITY);
				}
			}
			//volume regeling
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
	//loopen door recordingPlaylist
	for (i = 0; i < MAX_RECORDING; i++) {
		//als er een pauze is hoeven we niet te printen of het muziekbestand te intitializeren
		if(recordingPlaylist[i].songnummer != 111){
			printf("Playing song: %d\n", recordingPlaylist[i].songnummer);
			waveplay_start(recordingPlaylist[i].songnummer);
		}

		int j;
		for (j = 0; j <= recordingPlaylist[i].playticks; j++) {
			//per pauzetick wachten we 50ms
			if(recordingPlaylist[i].songnummer == 111){
				OSTimeDlyHMSM(0,0,0,50);
			}else if(!waveplay_execute(recordingPlaylist[i].songnummer));
			//volume regeling
			handle_key();
			//stop met loopen als de stop knop is ingedrukt
			if(playTouched(mtc2->x1, mtc2->y1)){
				j = recordingPlaylist[i].playticks;
				break;
			}
		}
		//stop met loopen als de stop knop is ingedrukt
		if(playTouched(mtc2->x1, mtc2->y1) || recordingPlaylist[i].songnummer == NULL) break;
	}
	playingRecording = FALSE;
	drawPlay();
	printf("TaskPlayRecording end\n");
	//delay als debounce
	OSTimeDlyHMSM(0,0,0,50);
	err = OSSemPost(SEM_recording);
	OSTaskDel(OS_PRIO_SELF);
}
