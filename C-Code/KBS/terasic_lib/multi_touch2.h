#ifndef MULTI_TOUCH2_H_
#define MULTI_TOUCH2_H_

typedef struct{
	alt_u32 TOUCH_I2C_BASE;
    alt_u32 TOUCH_INT_BASE;
    alt_u32 INT_IRQ_NUM;
}MTC2_INFO;


typedef struct{
    alt_u8 TouchNum;
    alt_u16 x1;
    alt_u16 y1;
    alt_u16 x2;
    alt_u16 y2;
    alt_u16 x3;
    alt_u16 y3;
    alt_u16 x4;
    alt_u16 y4;
    alt_u16 x5;
    alt_u16 y5;
}MTC2_EVENT;

MTC2_INFO* MTC2_Init(alt_u32 TOUCH_I2C_BASE,alt_u32 TOUCH_INT_BASE, alt_u32 INT_IRQ_NUM);
void MTC2_UnInit(MTC2_INFO *p);
void MTC2_ClearEvent(MTC2_INFO *p);

MTC2_EVENT *mtc2;

#endif /*MULTI_TOUCH_H_*/
