#include "includes.h"
#include "audio_f.c"
#include "main.h"

// UPLOAD COMMAND: nios2-download -g KBS.elf && nios2-terminal

/* The main function creates two task and starts multi-tasking */
int main(void)
{
	/* Semafoor init*/
	SEM_nPlayIndex = OSSemCreate(1);
	SEM_bSdacrdReady = OSSemCreate(1);
	SEM_szWaveFile = OSSemCreate(1);
	SEM_playing = OSSemCreate(1);
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
	//OSTaskCreate(TaskPlayMusic, NULL, (void *)&TaskPlayMusicStack[TASK_STACKSIZE-1], TaskPlayMusic_PRIORITY);
	OSTaskCreate(TaskKeyHandler, NULL, (void *)&TaskKeyHandlerStack[TASK_STACKSIZE-1], TaskKeyHandler_PRIORITY);
	//OSTaskCreate(TaskPlaySong, NULL/*song nummer*/, (void *)&TaskPlaySongStack[songPrio][TASK_STACKSIZE-1], 10); //todo prio nog aanpassen

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
	alt_u8 play_button;		//variabele die gekoppeld is aan de drukknop voor het afspelen van een bestand
	bool bPlay;				//variabele die bepaald of TaskPlaySong aangemaakt kan worden
	bool bPlay2;
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

		play_button = IORD_ALTERA_AVALON_PIO_DATA(KEY_BASE);
		play_button = IORD_ALTERA_AVALON_PIO_EDGE_CAP(KEY_BASE);
		IOWR_ALTERA_AVALON_PIO_EDGE_CAP(KEY_BASE, 0);
		bPlay = (play_button & 0x08)?TRUE:FALSE; //zet bPlay op TRUE als de meest linkse button (0x08) is ingedrukt
		if(bPlay && (songPrio <= MAX_SONGS) && bSdacrdReady)
		{
			//err = OSSemPost(SEM_playing);
			//maak de TaskPlaySong aan die een bestand gaat afspelen
			OSTaskCreate(TaskPlaySong, 1/*song nummer*/, (void *)&TaskPlaySongStack[songPrio][TASK_STACKSIZE-1], songPrio);
			//OSTaskCreate(TaskPlaySong, 0/*song nummer*/, (void *)&TaskPlaySongStack[TASK_STACKSIZE-1], TaskPlaySong_PRIORITY + 1);
			songPrio++;
//			OSTaskCreate(TaskPlaySong, 0/*song nummer*/, (void *)&TaskPlaySongStack[songPrio][TASK_STACKSIZE-1], songPrio);
//			songPrio++;
			lcdPrint = FALSE;
		}

		handle_key(); //overige knoppen nalopen, zoals volume regeling
		OSTimeDlyHMSM(0,0,0,100);
	}
}

//Speel een ingelezen .wav bestand af
//void TaskPlaySong(void * pdata)
//{
//	printf("TaskPlaySong created\n");
//	INT8U err;
//	int songsToPlay[18];
//	bool repeat;
//	bool bEndOfFile = FALSE;
//	bool bEndOfFile2 = FALSE;
//
//	while(1)
//	{
//		OSSemPend(SEM_playing ,0,&err);
//		repeat = TRUE;
//		while(repeat)
//		{
//
//
//			if(bEndOfFile && bEndOfFile2) repeat = FALSE;
//		}
//	}
//}

//Speel een ingelezen .wav bestand af
void TaskPlaySong(void * pdata)
{
	printf("TaskPlaySong created\n");
	INT8U err;
	//int songNummer = (int) pdata;
	bool repeat = TRUE;										//variabele die bepaald of er nog touchinput is

	//printf("Met taskplaysong: %s \n %s\n",gWavePlayList.szFilename[songNummer], gWavePlay[songNummer].szFilename);

	while (repeat){
		while(mtc2->TouchNum && repeat){
			int songNummer = getButtonId(mtc2->x1,mtc2->y1);
			waveplay_start(songNummer);
			bool bPlayDone = FALSE; 							//variabele die bepaald of het muziekje is afgelopen
			if (gWavePlay[songNummer]->readOk){					//als het .wav bestand niet kan worden gestart
				update_status(songNummer);						//update het lcd scherm
				while(!bPlayDone && bSdacrdReady && mtc2->TouchNum){
						OSSemPend(SEM_playing ,0,&err);
						if (!wave_play(songNummer)){//bestand afspelen, als hij klaar is wordt bEndOfFile TRUE
							printf("waveplay_execute error\r\n");
							lcd_display("Play Error.\n\n");
							OSSemPend(SEM_bSdacrdReady ,0,&err);
							bSdacrdReady = FALSE;
							err = OSSemPost(SEM_bSdacrdReady);
							repeat = FALSE;
						}
						//if (bSdacrdReady && (bEndOfFile)) bPlayDone = TRUE;
						handle_key(); 									//overige knoppen nalopen, zoals volume regeling
						//if(!repeatMode) repeat = FALSE;

						OSSemPost(SEM_playing);
						//OSTimeDly(1);
				}
			}else{
				repeat = FALSE;
			}
		}
		handle_key(); 									//overige knoppen nalopen, zoals volume regeling
	}
	songPrio--;
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
