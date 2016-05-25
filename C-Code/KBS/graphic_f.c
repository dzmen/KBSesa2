#include "graphic_f.h"

void graphic_init(){
    //koppel de i2c_core library aan de i2c verilog module
    oc_i2c_init(I2C_OPENCORES_0_BASE);
    usleep(1000);
    //koppel de touchscreen (adressen) aan de gemaakte pointer
    pTouch=MTC2_Init(I2C_OPENCORES_0_BASE,LCD_TOUCH_INT_BASE,LCD_TOUCH_INT_IRQ);
    if (!pTouch){
        printf("Failed to init multi-touch\r\n");
    }else{
        printf("Init touch successfully\r\n");

    }

    pReader =  VIPFR_Init(ALT_VIP_VFR_0_BASE, (void *)FR_FRAME, (void *)FR_FRAME, FRAME_WIDTH, FRAME_HEIGHT);

    //Activeer het scherm. Dit moet pas gebeuren als het scherm is ingesteld. Is maar 1 keer nodig.
    VIPFR_Go(pReader, TRUE);
    //Leeg het scherm (tekent box over het hele scherm)
    vid_clean_screen(pReader, BLACK_24);

    //Een teken functie. In graphic_lib/simple_graphics.c staan alle teken functies + uitleg
    int o;
    for (o = 0; o < 18; o++){
    	drawbutton(o);
    }

    // 18 / 3 = 6
    // 15 / 3 = 5

    vid_draw_round_corner_box (130, 420, 360, 460,5, GRAY_24, DO_FILL, pReader);
    vid_draw_circle(160, 440,10, RED_24, DO_FILL, pReader);
    vid_print_string_alpha(190, 425, BLACK_24, GRAY_24, tahomabold_20, pReader, "RECORD");

    vid_draw_round_corner_box (430, 420, 560, 460,5, GRAY_24, DO_FILL, pReader);
    //vid_draw_triangle(triangle_struct* tri, pReader);
    vid_print_string_alpha(490, 425, BLACK_24, GRAY_24, tahomabold_20, pReader, "PLAY");

    //Dit moet na elke tekenfase gebeuren. Deze functie refreshed het scherm met de nieuwe informatie.
    VIPFR_ActiveDrawFrame(pReader);
}

void drawbutton(int id){
	if(id < 6){
		vid_draw_round_corner_box (25+(130*id), 25+(130*0), 130+(130*id), 130+(130*0),5, LIGHTGREEN_24, DO_FILL, pReader);
	}else if(id < 12){
		vid_draw_round_corner_box (25+(130*(id-6)), 25+(130*1), 130+(130*(id-6)), 130+(130*1),5, LIGHTGREEN_24, DO_FILL, pReader);
	}else{
		vid_draw_round_corner_box (25+(130*(id-12)), 25+(130*2), 130+(130*(id-12)), 130+(130*2),5, LIGHTGREEN_24, DO_FILL, pReader);
	}
}

int getButtonId(int x, int y){
	//printf("%d x\n",x);
	if(y > 25 && y < 130){
		return (x-25)/130;
	}else if(y > 155 && y < 260){
		return (x-25)/130+6;
	}else if(y > 285 && y < 390){
		return (x-25)/130+12;
	}
	return 111;
}

int getTouched(){
    int X1, Y1, X2, Y2, X3, Y3, X4, Y4, X5, Y5,TouchNum;
    if (mtc2->TouchNum >= 1){
        switch(TouchNum)
        {
        case 5 :
        	//printf("%d p5\n",getButtonId(X5,Y5));
        case 4 :
        	//printf("%d p4\n",getButtonId(X4,Y4));
        case 3:
        	//printf("%d p3\n",getButtonId(X3,Y3));
        case 2:
        	//printf("%d p2\n",getButtonId(X2,Y2));
        case 1:
        	//printf("%d p1\n",getButtonId(X1,Y1)); break;
        default:break;
        }
    }
    return 0;
}


