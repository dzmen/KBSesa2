#include "includes.h"
#include "audio_f.h"
#include "main.h"

/////////////////////////////////////////////////////////////////
/////////// Display config & function ///////////////////////////
/////////////////////////////////////////////////////////////////

//Vernieuwd de tekst op het lcd scherm
//De tekst is de naam van het audiobestand en het volumeniveau
void update_status(int songnummer){
#ifdef LCD_DISPLAY
    char szText[64];
    sprintf(szText, "\r%s\nVol:%d(%d-%d)\n", gWavePlayList.szFilename[songnummer], volume,
        HW_MIN_VOL, HW_MAX_VOL);
    lcd_display((szText));
#endif
}

//Open het lcd scherm
void lcd_open(void){
#ifdef LCD_DISPLAY
    LCD_Open();
#endif
}

//Plaats een string op het lcd scherm
void lcd_display(char *pText){
#ifdef LCD_DISPLAY
    LCD_Clear();
    LCD_TextOut(pText);
#endif
}

/////////////////////////////////////////////////////////////////
/////////// Routing for detect SD-CARD //////////////////////////
/////////////////////////////////////////////////////////////////

//Wacht totdat er een sd-kaart wordt ingevoerd
//Geeft zowel op het lcd scherm als in de console weer dat er een sd-kaart moet worden ingevoerd
void wait_sdcard_insert(void){
    bool bFirstTime2Detect = TRUE;
    while(!SDLIB_Init()){
        if (bFirstTime2Detect){
            printf("Please insert SD card!\r\n");
            lcd_display(("\rPlease insert\nSD card!\n"));
            bFirstTime2Detect = FALSE;
        }
        OSTimeDlyHMSM(0,0,0,100);
    } // while
    printf("Find SD card\r\n");
    lcd_display(("\rSdcard read\nAwaiting input\n"));
}

/////////////////////////////////////////////////////////////////
/////////// Routing for building wave-file play list ////////////
/////////////////////////////////////////////////////////////////

//Controleerd of de sample rate van het audio bestand is toegestaan
bool is_supporrted_sample_rate(int sample_rate){
    bool bSupport = FALSE;
    switch(sample_rate){
        case 96000:
        case 48000:
        case 44100:
        case 32000:
        case 8000:
            bSupport = TRUE;
            break;
    }
    return bSupport;
}

//Deze functie looped door de inhoud van de sd card heen, controleerd op .wav files en voegd deze toe aan gWavePlay.
//Als er een fout optreed geef dan FALSE terug
int build_wave_play_list(FAT_HANDLE hFat){
    int count = 0;
    FAT_BROWSE_HANDLE hFileBrowse;
    //FAT_DIRECTORY Directory;
    FILE_CONTEXT FileContext;
    FAT_FILE_HANDLE hFile;
    alt_u8 szHeader[128];
    char szWaveFilename[MAX_FILENAME_LENGTH];
    int sample_rate;
    bool bFlag = FALSE;
    int nPos = 0;
    int length=0;

    gWavePlayList.nFileNum = 0;
    //checken of er bestanden zijn
    if (!Fat_FileBrowseBegin(hFat,&hFileBrowse)){
        printf("browse file fail.\n");
        return 0;
    }

    //loopen door de verschillende .wav bestanden
    while (Fat_FileBrowseNext(&hFileBrowse,&FileContext)){
        if (FileContext.bLongFilename){
			nPos = 0;
			alt_u16 *pData16;
			alt_u8 *pData8;
			pData16 = (alt_u16 *)FileContext.szName;
			pData8 = FileContext.szName;
			while(*pData16){
				if (*pData8 && *pData8 != ' ')
					szWaveFilename[nPos++] = *pData8;
				pData8++;
				if (*pData8 && *pData8 != ' ')
					szWaveFilename[nPos++] = *pData8;
				pData8++;
				//
				pData16++;
			}
			szWaveFilename[nPos] = 0;
			//printf("\n-- 1 Music Name:%s --\n",szWaveFilename);
		}else{
			strcpy(szWaveFilename,FileContext.szName);
			//printf("\n-- 2 Music Name:%s --\n",FileContext.szName);
		}
        //checken of de laatste 4 letters van de bestandsnaam overeenkomt met .wav
		length= strlen(szWaveFilename);
		if(length >= 4){
		   if((szWaveFilename[length-1] =='V' || szWaveFilename[length-1] =='v')
			&&(szWaveFilename[length-2] == 'A' || szWaveFilename[length-2] =='a')
			&&(szWaveFilename[length-3] == 'W' || szWaveFilename[length-3] == 'w')
			&&(szWaveFilename[length-4] == '.')){
			   bFlag = TRUE;
			}
		}
		//als de bestandsnaam klopt kunnen we gaan lezen
        if (bFlag){
            // parsing wave format
            hFile = Fat_FileOpen(hFat,szWaveFilename);
            if (!hFile){
                  printf("wave file open fail.\n");
                  continue;
            }
            printf("Read OK.\n");

            //memset(szHeader,0,sizeof(szHeader));

            if (!Fat_FileRead(hFile, szHeader, sizeof(szHeader))){
                  printf("wave file read fail.\n");
                  continue;
            }

            Fat_FileClose(hFile);

            // check wave format
            sample_rate =  Wave_GetSampleRate(szHeader, sizeof(szHeader));
            //printf("%i is de channel.\n", Wave_GetChannelNum(szHeader, sizeof(szHeader)));
            //printf("%i is de sample rate.\n", sample_rate);
            //printf("%i is de sample bit num.\n", Wave_GetSampleBitNum(szHeader, sizeof(szHeader)));
            //als de sample rate, channelnummer en samplebitsize kloppen voegen we het bestand toe aan de playlist
            if (is_supporrted_sample_rate(sample_rate) &&
                Wave_GetChannelNum(szHeader, sizeof(szHeader))==2 &&
                Wave_GetSampleBitNum(szHeader, sizeof(szHeader))==16){
                    strcpy(gWavePlayList.szFilename[count],szWaveFilename);
                    strcpy(gWavePlay[count].szFilename,szWaveFilename);
                    if(!waveplay_start(count)){
						gWavePlay[count].readOk = FALSE;
					} else{
						gWavePlay[count].readOk = TRUE;
					}
                    count++;

            }
        }
    } // while
    gWavePlayList.nFileNum = count;
    return count;
}

/////////////////////////////////////////////////////////////////
//// Function for wave playing /////////////////////////////////
/////////////////////////////////////////////////////////////////

//Controleer het .wav bestand en speel het af
//Als er een fout optreed geef dan FALSE terug
bool waveplay_start(int songnummer){
    bool bSuccess;

    //Zet de bestandsnaam in de struc gWavePlays
    printf("waves start: filename %s\n", gWavePlay[songnummer].szFilename);

    //Kijk of je het bestand kan openen
    gWavePlay[songnummer].hFile = Fat_FileOpen(hFat, gWavePlay[songnummer].szFilename);
    if (!gWavePlay[songnummer].hFile)
        printf("wave file open fail.\n");

    //Lees de .wav file en kijk of het is gelukt
    if (gWavePlay[songnummer].hFile){
        bSuccess = Fat_FileRead(gWavePlay[songnummer].hFile, gWavePlay[songnummer].szBuf, WAVE_BUF_SIZE);
        if (!bSuccess)
            printf("wave file read fail.\n");
    }
    //.wav formaat nogmaals controleren en vervolgens klaarzetten om af te spelen
    if (bSuccess){
		int sample_rate =  Wave_GetSampleRate(gWavePlay[songnummer].szBuf, WAVE_BUF_SIZE);
		if (is_supporrted_sample_rate(sample_rate) &&
			Wave_GetChannelNum(gWavePlay[songnummer].szBuf, WAVE_BUF_SIZE)==2 &&
			Wave_GetSampleBitNum(gWavePlay[songnummer].szBuf, WAVE_BUF_SIZE)==16){
			//magic happens
			gWavePlay[songnummer].uWavePlayPos = Wave_GetWaveOffset(gWavePlay[songnummer].szBuf, WAVE_BUF_SIZE);
			gWavePlay[songnummer].uWaveMaxPlayPos = gWavePlay[songnummer].uWavePlayPos + Wave_GetDataByteSize(gWavePlay[songnummer].szBuf, WAVE_BUF_SIZE);
			gWavePlay[songnummer].uWaveReadPos = WAVE_BUF_SIZE;

			// sample rate setten
			AUDIO_InterfaceActive(FALSE);
			if (sample_rate == 96000)
				AUDIO_SetSampleRate(RATE_ADC96K_DAC96K);
			else if (sample_rate == 48000)
				AUDIO_SetSampleRate(RATE_ADC48K_DAC48K);
			else if (sample_rate == 44100)
				AUDIO_SetSampleRate(RATE_ADC44K1_DAC44K1);
			else if (sample_rate == 32000)
				AUDIO_SetSampleRate(RATE_ADC32K_DAC32K);
			else if (sample_rate == 8000)
				AUDIO_SetSampleRate(RATE_ADC8K_DAC8K);
			else
				printf("unsupported sample rate=%d\n", sample_rate);
			AUDIO_FifoClear();
			AUDIO_InterfaceActive(TRUE);
		}else{
			bSuccess = FALSE;
		}
    }
    return bSuccess;
}

//.wav bestand afspelen
//Als er een fout optreed geef dan FALSE terug
bool waveplay_execute(bool *bEOF,int songnummer){
    bool bSuccess = TRUE;
    bool bDataReady = FALSE;

    //Controlleer of de WAV file is afgelopen
    if (gWavePlay[songnummer].uWavePlayPos >= gWavePlay[songnummer].uWaveMaxPlayPos){
        *bEOF = TRUE;
        return TRUE;
    }

    *bEOF = FALSE;
    while (!bDataReady && bSuccess){
        if (gWavePlay[songnummer].uWavePlayPos < gWavePlay[songnummer].uWaveReadPos){
            bDataReady = TRUE;
        }else{
            int read_size = WAVE_BUF_SIZE;
            if (read_size > (gWavePlay[songnummer].uWaveMaxPlayPos - gWavePlay[songnummer].uWavePlayPos))
                read_size = gWavePlay[songnummer].uWaveMaxPlayPos - gWavePlay[songnummer].uWavePlayPos;
            bSuccess = Fat_FileRead(gWavePlay[songnummer].hFile, gWavePlay[songnummer].szBuf, read_size);
            if (bSuccess)
                gWavePlay[songnummer].uWaveReadPos += read_size;
            else
                printf("[APP]sdcard read fail, read_pos:%ld, read_size:%d, max_play_pos:%ld !\r\n", gWavePlay[songnummer].uWaveReadPos, read_size, gWavePlay[songnummer].uWaveMaxPlayPos);
        }
    } // while

    //Speel een short van de WAV file wanneer hij alle data heeft
    if (bDataReady && bSuccess){
        int play_size;
        short *pSample = (short *)(gWavePlay[songnummer].szBuf + gWavePlay[songnummer].uWavePlayPos%WAVE_BUF_SIZE);
        int i = 0;
        play_size = gWavePlay[songnummer].uWaveReadPos - gWavePlay[songnummer].uWavePlayPos;
        play_size = play_size/4*4;
        while(i < play_size){
            if(AUDIO_DacFifoNotFull()){ // Als audio ready is (LIB functie)
                short ch_right, ch_left;
                ch_left = *pSample++;
                ch_right = *pSample++;

                AUDIO_DacFifoSetData(ch_left, ch_right); // Speel geluid links en rechts
                i+=4;
            }
        }
        gWavePlay[songnummer].uWavePlayPos += play_size;
    }

    return bSuccess;
}

//bool waveplay_execute(){
////    bool bSuccess = TRUE;
////    bool bDataReady = FALSE;
//
//
//
//    //kijken welke files mogen spelen todo nog doen
//    int songs[] = {0,2};
//
//    //controleren of er al een is afgelopen
//    for (int j = 0; j < sizeof(songs); ++j) {
//        if (gWavePlay[j].uWavePlayPos >= gWavePlay[j].uWaveMaxPlayPos){
//            songs[j] = NULL;
//        }
//    }
//
//    for (int j = 0; j < sizeof(songs); ++j) {
//        bool bSuccess = TRUE;
//        bool bDataReady = FALSE;
//
//        while (!bDataReady && bSuccess){
//            if (gWavePlay[j].uWavePlayPos < gWavePlay[j].uWaveReadPos){
//                bDataReady = TRUE;
//            }else{
//                int read_size = WAVE_BUF_SIZE;
//                if (read_size > (gWavePlay[j].uWaveMaxPlayPos - gWavePlay[j].uWavePlayPos))
//                    read_size = gWavePlay[j].uWaveMaxPlayPos - gWavePlay[j].uWavePlayPos;
//                bSuccess = Fat_FileRead(gWavePlay[j].hFile, gWavePlay[j].szBuf, read_size);
//                if (bSuccess)
//                    gWavePlay[j].uWaveReadPos += read_size;
//                else
//                    printf("[APP]sdcard read fail, read_pos:%ld, read_size:%d, max_play_pos:%ld !\r\n", gWavePlay[j].uWaveReadPos, read_size, gWavePlay[j].uWaveMaxPlayPos);
//            }
//        } // while
//    }
//
//    //Speel een short van de WAV file wanneer hij alle data heeft
//    if (bDataReady && bSuccess){
//        int play_size;
//        short *pSample = (short *)(gWavePlay[songnummer].szBuf + gWavePlay[songnummer].uWavePlayPos%WAVE_BUF_SIZE);
//        int i = 0;
//        play_size = gWavePlay[songnummer].uWaveReadPos - gWavePlay[songnummer].uWavePlayPos;
//        play_size = play_size/4*4;
//        while(i < play_size){
//            if(AUDIO_DacFifoNotFull()){ // Als audio ready is (LIB functie)
//                short ch_right, ch_left;
//                ch_left = *pSample++;
//                ch_right = *pSample++;
//
//                AUDIO_DacFifoSetData(ch_left, ch_right); // Speel geluid links en rechts
//                i+=4;
//            }
//        }
//        gWavePlay[songnummer].uWavePlayPos += play_size;
//    }
//
//    return bSuccess;
//}

/////////////////////////////////////////////////////////////////
/////////// Routing for button handle ///////////////////////////
/////////////////////////////////////////////////////////////////

//
void handle_key(){
    static bool bFirsTime2SetupVol = TRUE;
    alt_u8 button;
    bool bVolUp, bVolDown;
    int nHwVol;


#ifdef SUPPORT_PLAY_MODE
    bool bRepeat;
    bRepeat = (IORD_ALTERA_AVALON_PIO_DATA(SW_BASE) & 0x01)?TRUE:FALSE;
    if (bRepeat ^ repeatMode){
        repeatMode = bRepeat;
       // update_status();
    }
#endif

#ifdef ENABLE_DEBOUNCE
    static alt_u32 next_active_time = 0;
    if (alt_nticks() < next_active_time ){
        return;
    }
    next_active_time = alt_nticks();
#endif

    button = IORD_ALTERA_AVALON_PIO_DATA(KEY_BASE);
    button = IORD_ALTERA_AVALON_PIO_EDGE_CAP(KEY_BASE);
    IOWR_ALTERA_AVALON_PIO_EDGE_CAP(KEY_BASE, 0); // clear flag
    bVolUp = (button & 0x04)?TRUE:FALSE;
    bVolDown = (button & 0x02)?TRUE:FALSE;


    // adjust volument
    if (bVolUp || bVolDown || bFirsTime2SetupVol){
        nHwVol = volume;
        if (bFirsTime2SetupVol){
            bFirsTime2SetupVol = FALSE;
            printf("current volume %d(%d-%d)\r\n", nHwVol, HW_MIN_VOL, HW_MAX_VOL);
        }else if (bVolUp){
            if (nHwVol < HW_MAX_VOL)
                nHwVol++;
            printf("volume up %d(%d-%d)\r\n", nHwVol, HW_MIN_VOL, HW_MAX_VOL);
        }else{
            if (nHwVol > HW_MIN_VOL)
                nHwVol--;
            printf("volume down %d(%d-%d)\r\n", nHwVol, HW_MIN_VOL, HW_MAX_VOL);
        }
        AUDIO_SetLineOutVol(nHwVol, nHwVol);
        //update_status();
    }

#ifdef ENABLE_DEBOUNCE
    if (bNextSong || bVolUp || bVolDown){
        next_active_time +=  alt_ticks_per_second()/5;  // debounce
    }
#endif

}

bool Fat_Test(FAT_HANDLE hFat, char *pDumpFile){
    bool bSuccess;
    int nCount = 0;
    FAT_BROWSE_HANDLE hBrowse;
    FILE_CONTEXT FileContext;

    bSuccess = Fat_FileBrowseBegin(hFat, &hBrowse);
    if (bSuccess){
        while(Fat_FileBrowseNext(&hBrowse, &FileContext)){
            if (FileContext.bLongFilename){
                alt_u16 *pData16;
                alt_u8 *pData8;
                pData16 = (alt_u16 *)FileContext.szName;
                pData8 = FileContext.szName;
                printf("[%d]", nCount);
                while(*pData16){
                    if (*pData8)
                        printf("%c", *pData8);
                    pData8++;
                    if (*pData8)
                        printf("%c", *pData8);
                    pData8++;
                    //
                    pData16++;
                }
                printf("\n");
            }else{
                printf("---[%d]%s\n", nCount, FileContext.szName);
            }
            nCount++;
        }
    }
    if (bSuccess && pDumpFile && strlen(pDumpFile)){
        FAT_FILE_HANDLE hFile;
        hFile =  Fat_FileOpen(hFat, pDumpFile);
        if (hFile){
            char szRead[256];
            int nReadSize, nFileSize, nTotalReadSize=0;
            nFileSize = Fat_FileSize(hFile);
            if (nReadSize > sizeof(szRead))
                nReadSize = sizeof(szRead);
            printf("%s dump:\n", pDumpFile);
            while(bSuccess && nTotalReadSize < nFileSize){
                nReadSize = sizeof(szRead);
                if (nReadSize > (nFileSize - nTotalReadSize))
                    nReadSize = (nFileSize - nTotalReadSize);
                //
                if (Fat_FileRead(hFile, szRead, nReadSize)){
                    int i;
                    for(i=0;i<nReadSize;i++){
                        printf("%c", szRead[i]);
                    }
                    nTotalReadSize += nReadSize;
                }else{
                    bSuccess = FALSE;
                    printf("\nFaied to read the file \"%s\"\n", pDumpFile);
                }
            } // while
            if (bSuccess)
                printf("\n");
            Fat_FileClose(hFile);
        }else{
            bSuccess = FALSE;
            printf("Cannot find the file \"%s\"\n", pDumpFile);
        }
    }

    return bSuccess;
}
