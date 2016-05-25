#include "terasic_includes.h"
#include "multi_touch2.h"
#include "I2C_core.h"
#include "I2C.h"
#include "alt_types.h"

#define TRUE 1


static void mtc2_QueryData(MTC2_INFO *p){
    unsigned char reg_data[31];
    unsigned long x1,y1,x2,y2,x3,y3,x4,y4,x5,y5;
    if(OC_I2C_Read(p->TOUCH_I2C_BASE,I2C_FT5316_ADDR,0x00,reg_data,31))
        {
    			 mtc2->TouchNum = reg_data[2];
        		 x1 = ((reg_data[3]&0x0f)<<8)|reg_data[4];
        		 y1 = ((reg_data[5]&0x0f)<<8)|reg_data[6];
        		 x2 = ((reg_data[9]&0x0f)<<8)|reg_data[10];
        		 y2 = ((reg_data[11]&0x0f)<<8)|reg_data[12];

        		 x3 = ((reg_data[15]&0x0f)<<8)|reg_data[16];
				 y3 = ((reg_data[17]&0x0f)<<8)|reg_data[18];

				 x4 = ((reg_data[21]&0x0f)<<8)|reg_data[22];
				 y4 = ((reg_data[23]&0x0f)<<8)|reg_data[24];

				 x5 = ((reg_data[27]&0x0f)<<8)|reg_data[28];
				 y5 = ((reg_data[29]&0x0f)<<8)|reg_data[30];
				 //the register value (1024,600)
				 //change the value to (800,480)
        		 mtc2->x1=(x1*800)>>10;
        		 mtc2->y1=(y1/10)<<3;
        		 mtc2->x2=(x2*800)>>10;
        		 mtc2->y2=(y2/10)<<3;
        		 mtc2->x3=(x3*800)>>10;
				 mtc2->y3=(y3/10)<<3;
				 mtc2->x4=(x4*800)>>10;
				 mtc2->y4=(y4/10)<<3;
				 mtc2->x5=(x5*800)>>10;
				 mtc2->y5=(y5/10)<<3;

        }
}


#ifdef ALT_ENHANCED_INTERRUPT_API_PRESENT
static void mtc2_ISR(void* context){
#else
static void mtc2_ISR(void* context, alt_u32 id){
#endif
   MTC2_INFO *p = (MTC2_INFO *)context;
#ifdef ALT_ENHANCED_INTERRUPT_API_PRESENT
    alt_ic_irq_disable(LCD_TOUCH_INT_IRQ_INTERRUPT_CONTROLLER_ID,p->INT_IRQ_NUM);
#else
    alt_irq_disable(id);
#endif
    mtc2_QueryData(p);

    // Reset the edge capture register
    IOWR_ALTERA_AVALON_PIO_EDGE_CAP(p->TOUCH_INT_BASE,0);
#ifdef ALT_ENHANCED_INTERRUPT_API_PRESENT
    alt_ic_irq_enable(LCD_TOUCH_INT_IRQ_INTERRUPT_CONTROLLER_ID,p->INT_IRQ_NUM);
#else
    alt_irq_enable(id);
#endif
 }

MTC2_INFO* MTC2_Init(alt_u32 TOUCH_I2C_BASE,alt_u32 TOUCH_INT_BASE, alt_u32 INT_IRQ_NUM)
{
    MTC2_INFO *p;

    p = (MTC2_INFO *)malloc(sizeof(MTC2_INFO));
    mtc2 = (MTC2_EVENT *)malloc(sizeof(MTC2_EVENT));
    p->TOUCH_I2C_BASE=TOUCH_I2C_BASE;
    p->TOUCH_INT_BASE=TOUCH_INT_BASE;

    p->INT_IRQ_NUM = INT_IRQ_NUM;


//    // enable interrupt
    IOWR_ALTERA_AVALON_PIO_IRQ_MASK(p->TOUCH_INT_BASE, 0x00);
//    // clear capture flag
    IOWR_ALTERA_AVALON_PIO_EDGE_CAP(p->TOUCH_INT_BASE, 0x00);
 // register callback function
 //   error = alt_irq_register (p->INT_IRQ_NUM, p, mtc2_ISR);
#ifdef ALT_ENHANCED_INTERRUPT_API_PRESENT
  if ((alt_ic_isr_register(LCD_TOUCH_INT_IRQ_INTERRUPT_CONTROLLER_ID,
		                   p->INT_IRQ_NUM,
		                   mtc2_ISR,
		                   (void *)p,
		                   NULL
		                   ) != 0)){
 #else
  if ((alt_irq_register(p->INT_IRQ_NUM, (void *)p, mtc2_ISR) != 0)){
 #endif

	  printf(("[TOUCH]register IRQ fail\n"));
		  }else{
			  printf(("[TOUCH]register IRQ success\n"));
		  }
    IOWR_ALTERA_AVALON_PIO_IRQ_MASK(p->TOUCH_INT_BASE, 0x01);
    return p;
}

void MTC2_UnInit(MTC2_INFO *p){
    if (p){
        free(p);
    }
}



