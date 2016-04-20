#ifndef __DEFINITIONS_H__
#define __DEFINITIONS_H__

//===== UCOS include

#include "includes.h"

//===== Terasic includes

#include ".\terasic_lib\terasic_includes.h"
#include ".\terasic_fat\FatFileSystem.h"
#include ".\terasic_fat\FatInternal.h"
#include ".\terasic_lib\WaveLib.h"
#include ".\terasic_lib\AUDIO.h"
#include ".\terasic_sdcard\sd_lib.h"

//===== types ========

typedef signed char  alt_8;
typedef unsigned char  alt_u8;
typedef signed short alt_16;
typedef unsigned short alt_u16;
typedef signed long alt_32;
typedef unsigned long alt_u32;
typedef long long alt_64;
typedef unsigned long long alt_u64;

//===== display config =====

#define LCD_DISPLAY
#define SUPPORT_PLAY_MODE
#define xENABLE_DEBOUNCE

//===== constance definition =====
#define HW_MAX_VOL     127
#define HW_MIN_VOL     47
#define HW_DEFAULT_VOL  80

//===== structure definition =====

// return number of wave file
#define MAX_FILE_NUM    128
#define FILENAME_LEN    32

#endif
