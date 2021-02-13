#include <genesis.h>
#include "menu.h"
#include "sound.h"

u16 cursor;

#define SHOW_FRAMELOAD 0
#define INITIAL_BGM 9

#define ITEM_BGM 0
#define ITEM_SE1 1
#define ITEM_MAX 1

const char* channel_string[10] = {"---", "FM1", "FM2", "FM3", "FM4", "FM5", "FM6", "PS1", "PS2", "PS3"};

/* Temp text buffer */
static char buf[40];
static bool pause = FALSE;

void vbl_callback();
void init_menu();
void draw_instructions();
void draw_status(u16 x, u16 y);

/*
 *  Program entry
 */
int main(u16 hard)
{
	JOY_init();
	VDP_drawText("Initializing ...", 2, 2);
#if SHOW_FRAMELOAD
	SYS_showFrameLoad();
#endif

	/*
	 *  Initialize MDSDRV (done once)
	 */
	snd_init();

	/*
	 *  run MDSDRV in callback
	 */
	SYS_setVIntCallback(snd_update);

	/*
	 *  Draw menu
	 */
	init_menu();

	while(TRUE)
	{
		u16 action;

		action = menu_update();
		switch(action)
		{
			default:
				draw_status(12, 19);
				break;
			case MENU_ACTION_UD: // Update cursor
				break;
			case MENU_ACTION_LR: // Update value
				switch(menu_cursor)
				{
					default:
						break;
				}
				break;
			case MENU_ACTION_A: // Play music
				if(menu_cursor < ITEM_SE1)
					snd_request_bgm(menu_val[ITEM_BGM]);
				else
					snd_request_se(menu_val[ITEM_SE1]);
				break;
			case MENU_ACTION_B: // Stop music
				if(menu_cursor < ITEM_SE1)
					snd_stop_bgm();
				else
					snd_stop_se();
				break;
			case MENU_ACTION_C: // Fade music
				if(menu_cursor < ITEM_SE1)
					snd_fade_bgm();
				break;
			case MENU_ACTION_START:
				//pause ^= 1;
				break;
		}

		/*
		 * Print cpu load. Turns out that drawing the menu options consumes
		 * a lot more cycles than actually running the sound driver...
		 */
		sprintf(buf, "%3d", SYS_getCPULoad());
		VDP_drawText(buf, 35, 1);

		VDP_waitVSync();
	}
	return 0;
}

/*
 *  Initializes the menu options and draws the static text
 */
void init_menu()
{
	VDP_clearPlane(0, FALSE);
	menu_add_item(ITEM_BGM, "BGM", INITIAL_BGM, 0, 0x7f);
	menu_add_item(ITEM_SE1, "SE1", 0, 0, 1);

	menu_init(ITEM_MAX);

	VDP_setTextPalette(0);
	VDP_drawText("Dragon Spirit Sound Driver", 2, 2);
	VDP_drawText("%", 38, 1);
	VDP_drawText("Position:", 2, 19);
	VDP_drawText("Chn:", 2, 20);
	VDP_drawText("Ins:", 2, 21);
	VDP_drawText("Env:", 2, 22);
	VDP_drawText("Vol:", 2, 23);
	VDP_drawText("Frq:", 2, 24);
	VDP_drawText("Flag:", 2, 25);
};

/*
 *  Displays the currently used tracks for each request slot
 */
void draw_status(u16 x, u16 y)
{
	static u8 frame_cnt = 0;

	VDP_setTextPalette((pause) ? 1 : 0);
#if SHOW_FRAMELOAD
#else
	sprintf(buf, "%04x", snd_bgm.position);
	VDP_setTextPalette((pause) ? 1 : 0);
	VDP_drawText(buf, x, y);

	y++;
	x = 7;
	struct snd_channel* ch = &snd_bgm.channels[0];
	while(ch != &snd_bgm.channels[8])
	{
		switch(frame_cnt & 3)
		{
			case 0:
				if(ch->channel_id < 10)
				{
					VDP_drawText(channel_string[ch->channel_id], x, y);
				}
				else
				{
					intToStr(ch->channel_id, buf, 3);
					VDP_drawText(buf, x, y);
				}
				break;
			case 1:
				intToStr(ch->patch, buf, 3);
				VDP_drawText(buf, x, y+1);
				break;
			case 2:
				intToStr(ch->env, buf, 3);
				VDP_drawText(buf, x, y+2);
				break;
			case 3:
				intToStr(ch->volume, buf, 3);
				VDP_drawText(buf, x, y+3);
				break;
		}
		if(frame_cnt & 1)
		{
			intToStr(ch->note,buf, 3);
			VDP_drawText(buf, x, y+4);
		}
		else
		{
			intToHex(ch->flag,buf, 2);
			VDP_drawText(buf, x+1, y+5);
		}
		x += 4;
		ch++;
	}
	frame_cnt++;
#endif
}

