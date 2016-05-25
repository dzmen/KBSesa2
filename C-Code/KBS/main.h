#ifndef __MAIN_H__
#define __MAIN_H__

#include "includes.h"
#include "custom_type.h"

/* Task Stacks definities*/
#define   TASK_STACKSIZE       2048
OS_STK    TaskReadSDStack[TASK_STACKSIZE];
OS_STK    TaskKeyHandlerStack[TASK_STACKSIZE];

/* Task Priorities definities*/
#define TaskReadSD_PRIORITY      	4
#define TaskKeyHandler_PRIORITY     5

/* Semafoor definities*/
OS_EVENT * SEM_bSdacrdReady;

/* Globale variabelen*/
bool bSdacrdReady = FALSE;		//variabele die bij houdt of de sd kaart klaar is voor gebruik

/* Functie prototypes */
void TaskReadSD(void* pdata);
void TaskKeyHandler(void* pdata);

#endif
