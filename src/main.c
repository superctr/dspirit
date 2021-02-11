#include <genesis.h>
#include "menu.h"
#include "sound.h"

u16 cursor;

#define ITEM_BGM 0
#define ITEM_SE1 1
#define ITEM_MAX 1

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
				draw_status(12, 20);
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
	menu_add_item(ITEM_BGM, "BGM", 2, 0, 0x7f);
	menu_add_item(ITEM_SE1, "SE1", 0, 0, 1);

	menu_init(ITEM_MAX);

	VDP_setTextPalette(0);
	VDP_drawText("Dragon Spirit Sound Driver", 2, 2);
	VDP_drawText("%", 38, 1);
	VDP_drawText("Position:", 2, 20);
	VDP_drawText("Patch:", 2, 21);
	VDP_drawText("Volume:", 2, 22);
	VDP_drawText("Note:", 2, 23);
};

/*
 *  Displays the currently used tracks for each request slot
 */
void draw_status(u16 x, u16 y)
{
	sprintf(buf, "%04x", snd_bgm.position);
	VDP_setTextPalette((pause) ? 1 : 0);
	VDP_drawText(buf, x, y);
#if 1
	sprintf(buf, "%02x %02x %02x %02x %02x %02x %02x %02x",
			snd_bgm.channels[0].patch,
			snd_bgm.channels[1].patch,
			snd_bgm.channels[2].patch,
			snd_bgm.channels[3].patch,
			snd_bgm.channels[4].patch,
			snd_bgm.channels[5].patch,
			snd_bgm.channels[6].patch,
			snd_bgm.channels[7].patch);
	VDP_drawText(buf, x, y+1);
#else
	sprintf(buf, "%02x %02x %02x %04x",
			snd_bgm.channels[0].env,
			snd_bgm.channels[0].psg.env_mode,
			snd_bgm.channels[0].psg.env_phase,
			snd_bgm.channels[0].psg.env_counter);
#endif
	VDP_drawText(buf, x, y+1);
	sprintf(buf, "%02x %02x %02x %02x %02x %02x %02x %02x",
			snd_bgm.channels[0].volume,
			snd_bgm.channels[1].volume,
			snd_bgm.channels[2].volume,
			snd_bgm.channels[3].volume,
			snd_bgm.channels[4].volume,
			snd_bgm.channels[5].volume,
			snd_bgm.channels[6].volume,
			snd_bgm.channels[7].volume);
	VDP_drawText(buf, x, y+2);
	sprintf(buf, "%02x %02x %02x %02x %02x %02x %02x %02x",
			snd_bgm.channels[0].note,
			snd_bgm.channels[1].note,
			snd_bgm.channels[2].note,
			snd_bgm.channels[3].note,
			snd_bgm.channels[4].note,
			snd_bgm.channels[5].note,
			snd_bgm.channels[6].note,
			snd_bgm.channels[7].note);
	VDP_drawText(buf, x, y+3);
	sprintf(buf, "%02x %02x %02x %02x %02x %02x %02x %02x",
			snd_bgm.channels[0].flag,
			snd_bgm.channels[1].flag,
			snd_bgm.channels[2].flag,
			snd_bgm.channels[3].flag,
			snd_bgm.channels[4].flag,
			snd_bgm.channels[5].flag,
			snd_bgm.channels[6].flag,
			snd_bgm.channels[7].flag);
	VDP_drawText(buf, x, y+4);
}

