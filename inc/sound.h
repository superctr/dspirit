//=====================================================================
// Dragon Spirit Sound Driver (Based on QuattroPlay)
//
// Written by ctr
//=====================================================================

#define SND_MAX_SUB_STACK 4
#define SND_MAX_REPEAT_STACK 4
#define SND_MAX_LOOP_STACK 4

enum
{
	SND_MODE_DISABLED = 0,
	SND_MODE_FM = 1
};

enum
{
	SND_FLAG_PATCH = 0x80,
	SND_FLAG_KEYON = 0x40,
	SND_FLAG_BG = 0x02,
	SND_FLAG_FG = 0x01,
};

struct snd_fm
{
	u8 part;
	u8 offset;

	const u8* patch_ptr;
	u8 patch_lfo;
	u8 carrier;
	u8 tl[4];
};

struct snd_channel
{
	u8 channel_id;
	u8 mode;

	u8 flag;

	u8 patch;
	u8 legato;
	u8 transpose;
	u8 detune;
	u8 volume;

	u8 pan_lfo;
	u8 lfo;

	u8 gate_time;
	u8 gate_time_set;
	u8 delay;
//	u8 delay_set;

	union
	{
		u16 pitch;
		struct
		{
			u8 note;
			u8 frac;
		};
	};

	u16 last_pitch;

	u8 peg_set;
	u8 peg;
	const u8* peg_ptr;
	const u8* peg_loop;
	u16 peg_value;
	u8 peg_rate_set;
	u8 peg_rate;
	u8 peg_depth_set;
	u8 peg_depth;
//	u8 peg_data;
	u8 peg_counter;
	u16 peg_mod;

	union
	{
		struct snd_fm fm;
	};
};

struct snd_track
{
	u8 request;
	u8 current_id;

	u16 update_time;
	u8 base_tempo;
	u8 tempo;

	u16 position;

	u8 volume;

	u8 sub_stack_pos;
	u8 repeat_stack_pos;
	u8 loop_stack_pos;

	u16 sub_stack[SND_MAX_SUB_STACK];
	u16 repeat_stack[SND_MAX_REPEAT_STACK];
	u16 loop_stack[SND_MAX_LOOP_STACK];

	u8 sub_count[SND_MAX_SUB_STACK];
	u8 repeat_count[SND_MAX_REPEAT_STACK];
	u8 loop_count[SND_MAX_LOOP_STACK];

	struct snd_channel channels[8];
};

struct snd_track snd_bgm;
struct snd_track snd_se;

typedef void (*snd_vcmd_ptr_t)(struct snd_channel*, u8 length);
typedef void (*snd_tcmd_ptr_t)(struct snd_track*, u8 arg);

struct snd_cmd
{
	u8 length;
	u8 row_break;
	void* cmd_ptr;
};

void snd_init();
void snd_request_bgm(u8 id);
void snd_stop_bgm();
void snd_request_se(u8 id);
void snd_stop_se();
void snd_update();
