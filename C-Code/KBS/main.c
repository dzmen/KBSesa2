#include "includes.h"
#include "definitions.h"
#include "functions.c"

// UPLOAD COMMAND: nios2-download -g KBS.elf && nios2-terminal

/* Task Stacks definitie*/
#define   TASK_STACKSIZE       2048
OS_STK    TaskReadSDStack[TASK_STACKSIZE];
OS_STK    TaskKeyHandlerStack[TASK_STACKSIZE];
//OS_STK    TaskPlayMusicStack[TASK_STACKSIZE];
OS_STK    TaskPlaySongStack[TASK_STACKSIZE];

/* Task Priorities definitie*/
#define TaskReadSD_PRIORITY      	4
#define TaskKeyHandler_PRIORITY     6
//#define TaskPlayMusic_PRIORITY      9
#define TaskPlaySong_PRIORITY      	5

/* Semafoor definitie*/
OS_EVENT * SEM_nPlayIndex;
OS_EVENT * SEM_bSdacrdReady;
OS_EVENT * SEM_szWaveFile;

/* Functie prototypes */
void TaskReadSD(void* pdata);
//void TaskPlayMusic(void* pdata);
void TaskKeyHandler(void* pdata);
void TaskPlaySong(void* pdata);

/* Globale variabelen*/ //todo variabelen commenten en nalopen op gebruik in fucntions
int nPlayIndex;
bool bSdacrdReady = FALSE;
alt_u8 szWaveFile[FILENAME_LEN];

/* The main function creates two task and starts multi-tasking */
int main(void)
{
	/* Semafoor init*/
	SEM_nPlayIndex = OSSemCreate(1);
	SEM_bSdacrdReady = OSSemCreate(1);
	SEM_szWaveFile = OSSemCreate(1);

	/* APP init */
	lcd_open();
	if (!AUDIO_Init()){ //todo hier naar kijken
		printf("Audio Init fail!\n");
		lcd_display(("Audio Init fail!\n\n"));
		OSTaskDel(OS_PRIO_SELF);
	}

	memset(&gWavePlay, 0, sizeof(gWavePlay));
	gWavePlay.nVolume = HW_DEFAULT_VOL;
	AUDIO_SetLineOutVol(gWavePlay.nVolume, gWavePlay.nVolume);

	/* Task init*/
	//OSTaskCreate(TaskPlayMusic, NULL, (void *)&TaskPlayMusicStack[TASK_STACKSIZE-1], TaskPlayMusic_PRIORITY);
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

//Reageer op user input
void TaskKeyHandler(void * pdata)
{
	INT8U err;
	alt_u8 play_button;		//variabele die gekoppeld is aan de drukknop voor het afspelen van een bestand
	bool bPlay;				//variabele die bepaald of TaskPlaySong aangemaakt kan worden
	bool lcdPrint = FALSE; 	//variabele om te kijken of "Awaiting input" al is afgedrukt

	while(1)
	{
		OSSemPend(SEM_bSdacrdReady ,0,&err);
		//als bSdacrdReady FALSE is maken we TaskReadSD aan
		if(!bSdacrdReady) OSTaskCreate(TaskReadSD, NULL, (void *)&TaskReadSDStack[TASK_STACKSIZE-1], TaskReadSD_PRIORITY);
		err = OSSemPost(SEM_bSdacrdReady);

		if(!lcdPrint){
			printf("Awating input\n");
			lcd_display(("\rAwating input\n\n"));
			lcdPrint = TRUE;
		}

		//todo de volgende regels misschien implemeteren in handle_key()
		play_button = IORD_ALTERA_AVALON_PIO_DATA(KEY_BASE);
		play_button = IORD_ALTERA_AVALON_PIO_EDGE_CAP(KEY_BASE);
		IOWR_ALTERA_AVALON_PIO_EDGE_CAP(KEY_BASE, 0);
		bPlay = (play_button & 0x08)?TRUE:FALSE; //zet bPlay op TRUE als de meest linkse button (0x08) is ingedrukt

		if(bPlay)
		{
			//maak de TaskPlaySong aan die een bestand gaat afspelen
			OSTaskCreate(TaskPlaySong, NULL, (void *)&TaskPlaySongStack[TASK_STACKSIZE-1], TaskPlaySong_PRIORITY);
			lcdPrint = FALSE;
		}

		handle_key(); //overige knoppen nalopen, zoals volume regeling
		OSTimeDlyHMSM(0,0,0,100);
	}
}

//Speel een ingelezen .wav bestand af
void TaskPlaySong(void * pdata)
{
	printf("TaskPlaySong created\n");
	INT8U err;
	bool bPlayDone = FALSE; 					//variabele die bepaald of het muziekje is afgelopen

	strcpy(szWaveFile, gWavePlayList.szFilename[1]);

	OSSemPend(SEM_bSdacrdReady ,0,&err);
	if (!waveplay_start(szWaveFile)){			//als het .wav bestand niet kan worden gestart
		printf("waveplay_start error\r\n");
		lcd_display("Play Error.\n\n");
		bSdacrdReady = FALSE;
	}else{										//als het .wav bestand wel kan worden gestart
		printf("Play Song:%s\r\n", szWaveFile);
		update_status();						//update het lcd scherm
		while(!bPlayDone && bSdacrdReady){
			bool bEndOfFile = FALSE;
			if (!waveplay_execute(&bEndOfFile)){//bestand afspelen, als hij klaar is wordt bEndOfFile TRUE
				printf("waveplay_execute error\r\n");
				lcd_display("Play Error.\n\n");
				bSdacrdReady = FALSE;
			}
			handle_key(); 						//overige knoppen nalopen, zoals volume regeling
			if (bSdacrdReady && (bEndOfFile)) bPlayDone = TRUE;
		}
	}
	err = OSSemPost(SEM_bSdacrdReady);
	printf("TaskPlaySong done\n");
	OSTaskDel(OS_PRIO_SELF);
}

/* Speelt muziek af */
//void TaskPlayMusic(void* pdata)
//{
//	INT8U err;
//	while (1)
//	{
//		OSSemPend(SEM_bSdacrdReady ,0,&err);
//
//		while(bSdacrdReady){
//			// find a wave file
//			bool bPlayDone = FALSE;
//
//			OSSemPend(SEM_nPlayIndex,0,&err);
//			OSSemPend(SEM_szWaveFile,0,&err);
//			strcpy(szWaveFile, gWavePlayList.szFilename[nPlayIndex]);
//			err = OSSemPost(SEM_nPlayIndex);
//			printf("Play Song:%s\r\n", szWaveFile);
//
//			if (!waveplay_start(szWaveFile)){
//				printf("waveplay_start error\r\n");
//				lcd_display("Play Error.\n\n");
//				bSdacrdReady = FALSE;
//			}
//			err = OSSemPost(SEM_szWaveFile);
//			update_status();
//
//			while(!bPlayDone && bSdacrdReady){
//				bool bEndOfFile = FALSE;
//				// play wave file
//				if (!waveplay_execute(&bEndOfFile)){
//					printf("waveplay_execute error\r\n");
//					lcd_display("Play Error.\n\n");
//					bSdacrdReady = FALSE;
//				}
//				// handle key event
//				handle_key();
//				if (bSdacrdReady && (bEndOfFile)){
//					bool bNextSong = FALSE;
//					bool bLastSong = FALSE;
//
//					if(bEndOfFile) bNextSong = TRUE;
//					// check whether in REPEAT mode
//					if (gWavePlay.bRepeatMode){
//						bNextSong = FALSE;  // in repeat mode
//						bLastSong = FALSE;
//					}
//					if (bNextSong){  // index update for next song
//						OSSemPend(SEM_nPlayIndex,0,&err);
//						nPlayIndex++;
//						if (nPlayIndex >= gWavePlayList.nFileNum)
//							nPlayIndex = 0;
//						err = OSSemPost(SEM_nPlayIndex);
//					}
//					if (bLastSong){  // index update for last song
//						OSSemPend(SEM_nPlayIndex,0,&err);
//						nPlayIndex--;
//						if (nPlayIndex < 0)
//							nPlayIndex = gWavePlayList.nFileNum-1;
//						err = OSSemPost(SEM_nPlayIndex);
//					}
//					bPlayDone = TRUE;
//				}
//			}  // while(!bPlayNextSong && bSdacrdReady)
//		}  // while(bSdacrdReady)
//
//		err = OSSemPost(SEM_bSdacrdReady );
//	}
//}
