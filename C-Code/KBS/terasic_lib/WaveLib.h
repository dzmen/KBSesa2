#ifndef _INC_WAVE_LIB_H
#define _INC_WAVE_LIB_H

#include "terasic_includes.h"

#pragma pack(1)

typedef struct{
    alt_u32 ID;
    alt_u32 Size;
}CHUNK;

typedef struct{
    alt_u32 ID;
    alt_u32 Size;
    alt_u16  AudioFormat;
    alt_u16 NumChannels;
    alt_u32 SampleRate;
    alt_u32 ByteRate;
    alt_u16 BlockAlign;
    alt_u16 BitsPerSample;
}PCM_FORMAT_CHUNK;

typedef struct {
    alt_u32 ChunkID;
    alt_u32 ChunkSize;
    alt_u32 Format;
}WAVE_HEADER;

#pragma pack()

int waveGetChunkOffset(char *szWave, const int nSize, const unsigned int ChunkID);
bool WAVE_IsWaveFile(char *szWave, const int nSize);
int Wave_GetSampleRate(char *szWave, const int nSize);
int Wave_GetChannelNum(char *szWave, const int nSize);
int Wave_GetSampleBitNum(char *szWave, const int nSize);
int Wave_GetDataByteSize(char *szWave, const int nSize);
int Wave_GetWaveOffset(char *szWave, const int nSize);

#endif /* _INC_WAVE_LIB_H */
