#ifndef __GRAPHIC_F_c__
#define __GRAPHIC_F_c__

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
        printf("Init touch successfull\r\n");

    }

    pReader =  VIPFR_Init(ALT_VIP_VFR_0_BASE, (void *)FR_FRAME, (void *)FR_FRAME, FRAME_WIDTH, FRAME_HEIGHT);
    //Activeer het scherm. Dit moet pas gebeuren als het scherm is ingesteld. Is maar 1 keer nodig.
    VIPFR_Go(pReader, TRUE);
    //Leeg het scherm (tekent box over het hele scherm)
    vid_clean_screen(pReader, BLACK_24);
    //Een teken functie. In graphic_lib/simple_graphics.c staan alle teken functies + uitleg
    drawButtonsGrey();
    //Dit moet na elke tekenfase gebeuren. Deze functie refreshed het scherm met de nieuwe informatie.
    VIPFR_ActiveDrawFrame(pReader);
    mtc2->TouchNum = 0;
}

void drawButtonsGrey(){
    int id;
    for(id = 0; id < 18; id++){
        if(id < 6){
            vid_draw_round_corner_box (25+(130*id), 25+(130*0), 130+(130*id), 130+(130*0),5, GRAY_24, DO_FILL, pReader);
        }else if(id < 12){
            vid_draw_round_corner_box (25+(130*(id-6)), 25+(130*1), 130+(130*(id-6)), 130+(130*1),5, GRAY_24, DO_FILL, pReader);
        }else{
            vid_draw_round_corner_box (25+(130*(id-12)), 25+(130*2), 130+(130*(id-12)), 130+(130*2),5, GRAY_24, DO_FILL, pReader);
        }
    }
}

void drawButtonsColor(int songs){
    int songAmount = songs;
    int array[6] = {RED_24,DARKORANGE_24,YELLOW_24,DARKGREEN_24,DARKBLUE_24, DARKVIOLET_24};
    int color = 0;
    int id;
    for(id = 0; id < 18; id++){
        if(id < 6){
            vid_draw_round_corner_box (25+(130*id), 25+(130*0), 130+(130*id), 130+(130*0),5, (songAmount ? array[color] : GRAY_24), DO_FILL, pReader);
        }else if(id < 12){
            vid_draw_round_corner_box (25+(130*(id-6)), 25+(130*1), 130+(130*(id-6)), 130+(130*1),5, (songAmount ? array[color] : GRAY_24), DO_FILL, pReader);
        }else{
            vid_draw_round_corner_box (25+(130*(id-12)), 25+(130*2), 130+(130*(id-12)), 130+(130*2),5, (songAmount ? array[color] : GRAY_24), DO_FILL, pReader);
        }
        if(songAmount) songAmount--;
        color++;
        if(color >= 6) color = 0;
    }
}

void drawRecord(){
    vid_draw_round_corner_box (130, 420, 400, 460,5, DARKGREEN_24, DO_FILL, pReader);
    vid_draw_circle(160, 440,10, RED_24, DO_FILL, pReader);
    vid_print_string_alpha(190, 425, BLACK_24, DARKGREEN_24, tahomabold_20, pReader, "RECORD");
}

void drawRecording(){
    vid_draw_round_corner_box (130, 420, 400, 460,5, DARKGREEN_24, DO_FILL, pReader);
    vid_draw_circle(160, 440,10, RED_24, DO_FILL, pReader);
    vid_print_string_alpha(190, 425, BLACK_24, DARKGREEN_24, tahomabold_20, pReader, "STOP RECORDING");
}

void drawPlay(){
    vid_draw_round_corner_box (430, 420, 540, 460,5, DARKGREEN_24, DO_FILL, pReader);
    triangle_struct tri;
    tri.vertex_x[0] = 440;
    tri.vertex_x[1] = 440;
    tri.vertex_x[2] = 460;
    tri.vertex_y[0] = 430;
    tri.vertex_y[1] = 450;
    tri.vertex_y[2] = 440;
    tri.fill = DO_FILL;
    vid_draw_triangle(&tri, pReader);
    vid_print_string_alpha(470, 425, BLACK_24, DARKGREEN_24, tahomabold_20, pReader, "PLAY");
}

void drawStop(){
    vid_draw_round_corner_box (430, 420, 540, 460,5, DARKGREEN_24, DO_FILL, pReader);
    vid_draw_round_corner_box (440, 430, 460, 450,5, RED_24, DO_FILL, pReader);
    vid_print_string_alpha(470, 425, BLACK_24, DARKGREEN_24, tahomabold_20, pReader, "STOP");
}

void drawBlank(){
    vid_draw_round_corner_box (430, 420, 560, 460,5, BLACK_24, DO_FILL, pReader);
}

void drawMessage(char message[]){
    vid_draw_round_corner_box (130, 420, 600, 480, 5, BLACK_24, DO_FILL, pReader);
    vid_print_string_alpha(130, 420, WHITE_24, BLACK_24, tahomabold_20, pReader, message);
}

void drawSdcardBlank(){
    vid_draw_round_corner_box (100, 420, 900, 480, 5, BLACK_24, DO_FILL, pReader);
}

void drawVolume(alt_u8 volume){
    if(volume == 99) drawVolumeBlank();
	char string[81];
	sprintf(string, "VOL: %u", volume);
    vid_print_string_alpha(600, 425, WHITE_24, BLACK_24, tahomabold_20, pReader, string);
}

void drawVolumeBlank(){
	vid_draw_round_corner_box(600, 425, 800, 1000, 5, BLACK_24, DO_FILL, pReader);
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

bool recordTouched(int x, int y){
    if(y > 420 && y < 460 && x > 130 && x < 360) {
        return TRUE;
    } else{
        return FALSE;
    }
}

bool playTouched(int x, int y){
    if(y > 420 && y < 460 && x > 430 && x < 560) {
        return TRUE;
    } else{
        return FALSE;
    }
}

void resetTouchCoordinates(){
    mtc2->x1 = 0;
    mtc2->y1 = 0;
}

#endif
