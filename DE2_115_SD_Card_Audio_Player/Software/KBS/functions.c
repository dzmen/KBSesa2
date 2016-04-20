#include "functions.h"
#include "definitions.h"

/////////////////////////////////////////////////////////////////
/////////// Display config & function ///////////////////////////
/////////////////////////////////////////////////////////////////

void update_status(void){
#ifdef LCD_DISPLAY
    char szText[64];
    sprintf(szText, "\r%s\nVol:%d(%d-%d)\n", gWavePlay.szFilename, gWavePlay.nVolume,
        HW_MIN_VOL, HW_MAX_VOL);
    lcd_display((szText));
#endif
}

void lcd_open(void){
#ifdef LCD_DISPLAY
    LCD_Open();
#endif
}

void lcd_display(char *pText){
#ifdef LCD_DISPLAY
    LCD_Clear();
    LCD_TextOut(pText);
#endif
}


/////////////////////////////////////////////////////////////////
/////////// Routing for detect SD-CARD //////////////////////////
/////////////////////////////////////////////////////////////////

void wait_sdcard_insert(void){
    bool bFirstTime2Detect = TRUE;
    while(!SDLIB_Init()){
        if (bFirstTime2Detect){
            printf("Please insert SD card!\r\n");
            lcd_display(("\rPlease insert\nSD card!\n"));
            bFirstTime2Detect = FALSE;
        }
        usleep(100*1000);
    } // while
    printf("Find SD card\r\n");

}

/////////////////////////////////////////////////////////////////
/////////// Routing for building wave-file play list ////////////
/////////////////////////////////////////////////////////////////

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
    //
    gWavePlayList.nFileNum = 0;
    if (!Fat_FileBrowseBegin(hFat,&hFileBrowse)){
        printf("browse file fail.\n");
        return 0;
    }

    //
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
                //printf("\n--Music Name:%s --\n",szWaveFilename);
            }else{
                strcpy(szWaveFilename,FileContext.szName);
                //printf("\n--Music Name:%s --\n",FileContext.szName);
            }

            length= strlen(szWaveFilename);
            if(length >= 4){
               if((szWaveFilename[length-1] =='V' || szWaveFilename[length-1] =='v')
                &&(szWaveFilename[length-2] == 'A' || szWaveFilename[length-2] =='a')
                &&(szWaveFilename[length-3] == 'W' || szWaveFilename[length-3] == 'w')
                &&(szWaveFilename[length-4] == '.')){
                   bFlag = TRUE;
                }
            }

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
            if (WAVE_IsWaveFile(szHeader, sizeof(szHeader)) &&
                is_supporrted_sample_rate(sample_rate) &&
                Wave_GetChannelNum(szHeader, sizeof(szHeader))==2 &&
                Wave_GetSampleBitNum(szHeader, sizeof(szHeader))==16){
                    strcpy(gWavePlayList.szFilename[count],szWaveFilename);
                    count++;
            }
        }
    } // while
    gWavePlayList.nFileNum = count;

    //Fat_FileBrowseEnd(&hFileBrowse);

    return count;
}

/////////////////////////////////////////////////////////////////
//// Function for wave playing /////////////////////////////////
/////////////////////////////////////////////////////////////////

void waveplay_stop(void);

bool waveplay_start(char *pFilename){
    bool bSuccess;
    int nSize;
    //waveplay_stop();

  //  strcpyn(gWavePlay.szFilename, pFilename, FILENAME_LEN-1);
    strcpy(gWavePlay.szFilename, pFilename);
    gWavePlay.hFile = Fat_FileOpen(hFat, pFilename);
    if (!gWavePlay.hFile)
        printf("wave file open fail.\n");

    //gWavePlay.szBuf = Fat_FileSize(gWavePlay.hFile);
    nSize = Fat_FileSize(gWavePlay.hFile);

    if (gWavePlay.hFile){
        bSuccess = Fat_FileRead(gWavePlay.hFile, gWavePlay.szBuf, WAVE_BUF_SIZE);
        if (!bSuccess)
            printf("wave file read fail.\n");
    }

                        // check wave format
    if (bSuccess){
            int sample_rate =  Wave_GetSampleRate(gWavePlay.szBuf, WAVE_BUF_SIZE);
            if (WAVE_IsWaveFile(gWavePlay.szBuf, WAVE_BUF_SIZE) &&
                is_supporrted_sample_rate(sample_rate) &&
                Wave_GetChannelNum(gWavePlay.szBuf, WAVE_BUF_SIZE)==2 &&
                Wave_GetSampleBitNum(gWavePlay.szBuf, WAVE_BUF_SIZE)==16){

                gWavePlay.uWavePlayPos = Wave_GetWaveOffset(gWavePlay.szBuf, WAVE_BUF_SIZE);
                gWavePlay.uWaveMaxPlayPos = gWavePlay.uWavePlayPos + Wave_GetDataByteSize(gWavePlay.szBuf, WAVE_BUF_SIZE);
                gWavePlay.uWaveReadPos = WAVE_BUF_SIZE;

                // setup sample rate
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


                printf("sample rate=%d\n", sample_rate);
            }else{
                bSuccess = FALSE;
            }
    }

    if (!bSuccess)
        waveplay_stop();

    return bSuccess;
}

bool waveplay_execute(bool *bEOF){
    bool bSuccess = TRUE;
    bool bDataReady = FALSE;


    // end of play data !
    if (gWavePlay.uWavePlayPos >= gWavePlay.uWaveMaxPlayPos){
        *bEOF = TRUE;
        return TRUE;
    }

    //
    *bEOF = FALSE;
    while (!bDataReady && bSuccess){
        if (gWavePlay.uWavePlayPos < gWavePlay.uWaveReadPos){
            bDataReady = TRUE;
            //DEBUG_PRINTF("it is not neccessary to read data from sd-card\r\n");
        }else{
            int read_size = WAVE_BUF_SIZE;
            if (read_size > (gWavePlay.uWaveMaxPlayPos - gWavePlay.uWavePlayPos))
                read_size = gWavePlay.uWaveMaxPlayPos - gWavePlay.uWavePlayPos;
            bSuccess = Fat_FileRead(gWavePlay.hFile, gWavePlay.szBuf, read_size);
            if (bSuccess)
                gWavePlay.uWaveReadPos += read_size;
            else
                printf("[APP]sdcard read fail, read_pos:%ld, read_size:%d, max_play_pos:%ld !\r\n", gWavePlay.uWaveReadPos, read_size, gWavePlay.uWaveMaxPlayPos);
        }
    } // while

    //
    if (bDataReady && bSuccess){
        int play_size;
        short *pSample = (short *)(gWavePlay.szBuf + gWavePlay.uWavePlayPos%WAVE_BUF_SIZE);
        int i = 0;
        play_size = gWavePlay.uWaveReadPos - gWavePlay.uWavePlayPos;
        play_size = play_size/4*4;
        while(i < play_size){
            if(AUDIO_DacFifoNotFull()){ // if audio ready (not full)
                short ch_right, ch_left;
                ch_left = *pSample++;
                ch_right = *pSample++;

                AUDIO_DacFifoSetData(ch_left, ch_right); // play wave
                i+=4;
            }
        } // while
        gWavePlay.uWavePlayPos += play_size;

    } //

    return bSuccess;
}

void waveplay_stop(void){
    /*if (gWavePlay.hFile.IsOpened){
        Fat_FileClose(&gWavePlay.hFile);
    }*/
}

/////////////////////////////////////////////////////////////////
/////////// Routing for button handle ///////////////////////////
/////////////////////////////////////////////////////////////////
// return true if next-song
void handle_key(){
    static bool bFirsTime2SetupVol = TRUE;
    alt_u8 button;
    bool bVolUp, bVolDown;
    int nHwVol;


#ifdef SUPPORT_PLAY_MODE
    bool bRepeat;
    bRepeat = (IORD_ALTERA_AVALON_PIO_DATA(SW_BASE) & 0x01)?TRUE:FALSE;
    if (bRepeat ^ gWavePlay.bRepeatMode){
        gWavePlay.bRepeatMode = bRepeat;
        update_status();
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
        nHwVol = gWavePlay.nVolume;
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
        gWavePlay.nVolume = nHwVol;
        update_status();
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
