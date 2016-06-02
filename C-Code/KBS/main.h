#ifndef __MAIN_H__
#define __MAIN_H__

#include "includes.h"
#include "custom_type.h"

// Task Stacks definities
#define   TASK_STACKSIZE       2048
OS_STK    TaskReadSDStack[TASK_STACKSIZE];
OS_STK    TaskKeyHandlerStack[TASK_STACKSIZE];
OS_STK    TaskPlayRecordingStack[TASK_STACKSIZE];

// Task Priorities definities
#define TaskReadSD_PRIORITY      	4
#define TaskKeyHandler_PRIORITY     8
#define TaskPlayRecording_PRIORITY  6

// Semafoor definities
OS_EVENT * SEM_recording;

// Functie prototypes
void TaskReadSD(void* pdata);
void TaskKeyHandler(void* pdata);
void TaskPlayRecording(void * pdata);

// Globale variabelen
typedef struct{
    int songnummer;
    int playticks;
}RECORDING_PLAYLIST;

#define MAX_RECORDING   40
static RECORDING_PLAYLIST recordingPlaylist[MAX_RECORDING];
bool sdCardReady = FALSE;		//variabele die bij houdt of de sd kaart klaar is voor gebruik



#endif
