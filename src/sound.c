//=====================================================================
// Dragon Spirit Sound Driver (Based on QuattroPlay)
//
// Written by ctr
//=====================================================================

#include <genesis.h>
#include <kdebug.h>

#include "sdata.h"
#include "sound.h"

//=====================================================================
// CONSTANTS
//=====================================================================

#define SND_FADE_RATE 0x40
#define SND_BGM_FM_ATTENUATE 6
#define SND_BGM_PSG_ATTENUATE 0
#define SND_SE_FM_ATTENUATE 0
#define SND_SE_PSG_ATTENUATE 0

enum
{
	SND_MODE_DISABLED = 0,
	SND_MODE_FM = 1,
	SND_MODE_PSG = 2,
};

enum
{
	ENV_MODE_TONE = 0x80,
	ENV_MODE_2CH_ENABLE = 0x40,
	ENV_MODE_2CH_TONE = 0x20,
	ENV_MODE_2CH_FINE_TUNE = 0x10,
	ENV_MODE_NOISE_ENABLE = 0x08,
	ENV_MODE_NOISE_MODE = 0x07
};
enum
{
	SND_FLAG_FG = 0x80,
	SND_FLAG_PATCH = 0x40, // FM patch defined
	SND_FLAG_KEYON = 0x20,
	SND_FLAG_KEYOFF = 0x10,
	SND_FLAG_ENV = 0x08, // PSG envelope defined
	SND_FLAG_LFO = 0x04, // lfo loaded
};

//=====================================================================
// VARIABLES
//=====================================================================

struct snd_track snd_bgm;
struct snd_track snd_se;
u16 snd_se_flag;

static const u16 snd_fm_fnum_table[21];
static const s8 snd_psg_vol_table[128];
static u8 snd_track_se;
static u8 snd_track_vol;
static u8 snd_fm_attenuate;
static u8 snd_psg_attenuate;

static u8 snd_lfo;
static u8 snd_lfo_depth;

static union
{
	u16 ctr;
	struct {
		u8 ctr_hi;
		u8 ctr_lo;
	};
} snd_bgm_fade;
static u8 snd_break;
static void snd_kill_channel(struct snd_channel *channel);
static inline void snd_update_track(struct snd_track *track, u8 se);

//=====================================================================
// PUBLIC FUNCTIONS
//=====================================================================
void snd_init()
{
	Z80_init();
	Z80_loadDriver(Z80_DRIVER_2ADPCM,1);
	memset(&snd_bgm, 0, sizeof(snd_bgm));
	snd_se_flag = 0;
	snd_bgm_fade.ctr = 0;
	snd_lfo = -1;
	snd_lfo_depth = 0xff;
}

void snd_request_bgm(u8 id)
{
	snd_bgm.request = id;
}

void snd_stop_bgm()
{
	snd_bgm.request = 0xfe;
}

void snd_fade_bgm()
{
	snd_bgm.request = 0xff;
}

void snd_request_se(u8 id)
{
}

void snd_stop_se()
{
}

void snd_update()
{
	snd_update_track(&snd_bgm, 0);

}

//=====================================================================
// PRIVATE FUNCTIONS
//=====================================================================
static inline const u8* get_u8(u16 pos)
{
	return &dsmusic[pos];
}
static inline u8 read_u8(u16 pos)
{
	return dsmusic[pos];
}
static inline u16 read_u16(u16 pos)
{
	return (dsmusic[pos]<<8)|dsmusic[pos+1];
}

static inline void take_z80()
{
	Z80_requestBus(1);
}

static inline void release_z80()
{
	while (YM2612_read(0) & 0x80);
	YM2612_write(0, 0x2a); //restore DAC register
	Z80_releaseBus();
}

//=====================================================================
// PITCH ENVELOPE
//=====================================================================
static inline void snd_set_peg(struct snd_channel* ch)
{
	ch->peg_loop = ch->peg_ptr = get_u8(read_u16(read_u16(6) + (ch->peg << 1)));
	ch->peg_counter = 0;
}

static inline void snd_set_peg_mod(struct snd_channel* ch)
{
	u8 depth = ch->peg_depth;
	s16 val = (ch->peg_value - 0x6400) >> 1;
	s32 mod = (val * depth) >> 8;
	ch->peg_mod = mod & 0xffff;
}

static void snd_update_peg(struct snd_channel* ch)
{
	if(!ch->peg)
		return;
	u16 counter = ch->peg_counter + ch->peg_rate;

	if(counter > 0xff)
		ch->peg_ptr++;

	u8 data = ch->peg_ptr[0];
	u8 target = ch->peg_ptr[1];

	if(target == 0xfd)
	{
		ch->peg ++;
		snd_set_peg(ch);
		ch->peg_counter = 0;
		return;
	}
	else if(target == 0xfe)
	{
		ch->peg_ptr = ch->peg_loop;
		ch->peg_counter = 0;
		return;
	}
	else if(target > 0xf0)
	{
		ch->peg = 0;
		ch->peg_value = data << 8;
		return snd_set_peg_mod(ch);
	}

	counter &= 0xff;
	ch->peg_counter = counter;

	u16 step = (target - data) * counter;
	ch->peg_value = (data << 8) + step;
	return snd_set_peg_mod(ch);
}

//=====================================================================
// FM SOUND UPDATE
//=====================================================================
static inline void snd_write_fm_common(u8 reg, u8 data)
{
	while (YM2612_read(0) & 0x80);
	YM2612_writeReg(0, reg, data);
}

static inline void snd_write_fm(struct snd_channel* ch, u8 reg, u8 data)
{
	while (YM2612_read(0) & 0x80);
	YM2612_writeReg(ch->fm.part, reg + ch->fm.offset, data);
}

static inline void snd_write_fm_nobusy(struct snd_channel* ch, u8 reg, u8 data)
{
	YM2612_writeReg(ch->fm.part, reg + ch->fm.offset, data);
}

static inline void snd_write_key(struct snd_channel* ch, u8 mask)
{
	take_z80();
	YM2612_writeReg(0, 0x28, (mask << 4) | (ch->fm.part << 2) | ch->fm.offset);
	release_z80();
}

static inline void snd_fm_set_volume(struct snd_channel* ch)
{
	if(~ch->flag & SND_FLAG_PATCH)
		return;
	for(int i = 0; i <= ch->fm.carrier; i++)
	{
		u16 d = ~(((ch->fm.patch_ptr[0x0b - i] & 0x7f) ^ 0x7f) * ch->volume) >> 8;
		ch->fm.tl[i] = d & 0x7f;
	}
}

static inline void snd_fm_set_patch(struct snd_channel* ch)
{
	static const u8 fm_con[8] = {0, 0, 0, 0, 1, 2, 2, 3};

	snd_write_key(ch, 0);
	take_z80();
	const u8* ptr = get_u8(read_u16(8) + (ch->patch << 5));

	for(int i = 0; i < 4; i++)
		snd_write_fm(ch, 0x80, 0xff);

	ch->fm.patch_ptr = ptr;
	ch->fm.carrier = fm_con[ptr[0] & 7];
	ch->fm.patch_lfo = ((ptr[3] & 0x70) >> 4) | ((ptr[3] & 3) << 4);
	ch->pan_lfo = 0xc0;

	snd_write_fm_nobusy(ch, 0xb4, 0x00);
	snd_write_fm_nobusy(ch, 0xb0, ptr[0] & 0x3f);

	ptr += 4;
	for(int i = 0; i < 24*4; i += 4)
		snd_write_fm(ch, 0x30 + i, *ptr++);

	for(int i = 0; i <= ch->fm.carrier; i++)
		snd_write_fm(ch, 0x4c - (i << 2), 0x7f);

	snd_write_fm(ch, 0xb4, ch->pan_lfo);
	release_z80();

	snd_fm_set_volume(ch);
}

static inline void snd_fm_write_volume(struct snd_channel* ch)
{
	take_z80();
	for(int i = 0; i <= ch->fm.carrier; i++)
	{
		u8 volume = ch->fm.tl[i] + snd_fm_attenuate;
		if(volume > 0x7f)
			volume = 0x7f;
		snd_write_fm(ch, 0x4c - (i << 2), volume);
	}
	release_z80();
}

static inline void snd_fm_set_lfo(struct snd_channel* ch)
{
	u8 lfo = ch->lfo;
	u8 pan_lfo = ch->pan_lfo & 0xc0;
	if(lfo != 0xff)
	{
		if(lfo != snd_lfo)
		{
			const u8* ptr = get_u8(read_u16(4) + (lfo << 1));
			snd_lfo = lfo;
			snd_lfo_depth = *ptr++;

			take_z80();
			YM2612_writeReg(0, 0x22, *ptr);
			release_z80();
		}

		if(ch->lfo)
		{
			const u8 ams_sub = snd_lfo_depth & 0x30;
			const u8 pms_sub = snd_lfo_depth & 0x07;
			s8 ams = ch->fm.patch_lfo & 0x30;
			s8 pms = ch->fm.patch_lfo & 0x07;
			ch->pan_lfo &= 0xc0;

			if(ams && ams_sub < 0x30)
			{
				if((ams - ams_sub) >= 0)
					pan_lfo |= ams - ams_sub;
				else
					pan_lfo |= 0x10;
			}
			if(pms && pms_sub < 0x07)
			{
				if((pms - pms_sub) >= 0)
					pan_lfo |= pms - pms_sub;
				else
					pan_lfo |= 0x01;
			}
		}
	}
	ch->pan_lfo = pan_lfo;
	take_z80();
	snd_write_fm(ch, 0xb4, ch->pan_lfo);
	release_z80();
}

static inline void snd_fm_update_reset(struct snd_channel* ch)
{
	if((~ch->flag & SND_FLAG_KEYON) || ch->delay)
		return;
	ch->peg = ch->peg_set;
	if(ch->peg)
	{
		ch->peg_depth = ch->peg_depth_set;
		ch->peg_rate = ch->peg_rate_set;
		snd_set_peg(ch);
	}
	ch->peg_mod = 0;

	if(ch->flag & SND_FLAG_LFO)
	{
		ch->flag &= ~SND_FLAG_LFO;
		snd_fm_set_lfo(ch);
	}

	snd_fm_write_volume(ch);
}

static inline void snd_fm_update_gate(struct snd_channel* ch)
{
	if(ch->gate_time && !(--ch->gate_time))
		return snd_write_key(ch, 0x00);
}

static inline void snd_fm_update_lfo(struct snd_channel* ch)
{
}

static inline void snd_fm_update_pitch(struct snd_channel* ch)
{
	union
	{
		u16 pitch;
		struct
		{
			u8 note;
			u8 frac;
		};
	} p;
	u8 octave;
	const u16* base;

	p.note = ch->transpose;
	p.frac = ch->detune;
	p.pitch += ch->pitch + ch->peg_mod;

	if(p.pitch != ch->last_pitch)
	{
		ch->last_pitch = p.pitch;

		octave = p.note / 12;
		base = &snd_fm_fnum_table[p.note % 12];

		p.pitch = base[0] + (((base[1] - base[0]) * p.frac) >> 8) + ((octave & 7) << 11);

		take_z80();
		snd_write_fm(ch, 0xa4, p.note);
		snd_write_fm(ch, 0xa0, p.frac);
		release_z80();
	}
}

static inline void snd_fm_update(struct snd_channel* ch)
{
	if(!(ch->flag & SND_FLAG_PATCH))
		return;

	snd_fm_update_gate(ch);
	snd_fm_update_reset(ch);
	snd_fm_update_lfo(ch);
	snd_update_peg(ch);
	snd_fm_update_pitch(ch);

	if(ch->flag & SND_FLAG_KEYON)
	{
		if(ch->delay)
		{
			ch->delay--;
		}
		else
		{
			snd_write_key(ch, 15);
			ch->gate_time = ch->gate_time_set;
			ch->flag &= ~(SND_FLAG_KEYON|SND_FLAG_KEYOFF);
		}
	}
}

//=====================================================================
// PSG SOUND UPDATE
//=====================================================================
static inline void snd_psg_write_volume(struct snd_channel* ch)
{
	s8 vol_index = (ch->volume >> 1) - snd_psg_attenuate;
	if(vol_index < 0)
		vol_index = 0;
	s8 vol = snd_psg_vol_table[(u8)vol_index] - (ch->psg.env_counter >> 4);
	if(vol < 0)
		vol = 0;
	else if(vol > 0x0f)
		vol = 0x0f;
	if(ch->psg.env_mode & ENV_MODE_TONE)
		PSG_write((ch->psg.offset + 0x10) | vol);
	if(ch->psg.env_mode & ENV_MODE_2CH_TONE)
		PSG_write((ch->psg.offset + 0x30) | ((vol + ch->psg.link_vol) > 15 ? 15 : vol + ch->psg.link_vol));
	if(ch->psg.env_mode & ENV_MODE_NOISE_ENABLE)
		PSG_write(0xf0 | vol);
}

static inline void snd_psg_write_noise(struct snd_channel* ch)
{
	PSG_write(0xe0 | (ch->psg.env_mode & 0x07));
}

static inline void snd_psg_write_freq(u8 channel, u16 data)
{
	if(data > 1023)
		data = 1023;
	PSG_write(channel | (data & 0x0f));
	PSG_write(data >> 4);
}

static inline void snd_psg_set_env(struct snd_channel* ch)
{
	// Clear previous env mode if needed
	if(ch->psg.env_mode & ENV_MODE_2CH_TONE)
		PSG_write(ch->psg.offset + 0x3f);
	if(ch->psg.env_mode & ENV_MODE_NOISE_ENABLE)
		PSG_write(0xff);

	const u8* ptr = get_u8(read_u16(2) + (ch->env << 3));

	ch->psg.env_ptr = ptr;
	ch->psg.env_mode = *ptr;
	ch->last_pitch = 0xffff;

	if(!(ch->psg.env_mode & ENV_MODE_TONE))
		PSG_write(ch->psg.offset + 0x1f);
}

static inline void snd_psg_update_env(struct snd_channel* ch)
{
	u8 rate_pos[5] = {0, 3, 4, 6, 7};
	u8 phase = ch->psg.env_phase;
	if(!phase)
		return;

	if(ch->flag & SND_FLAG_KEYOFF)
	{
		phase = 4;
		ch->flag &= ~SND_FLAG_KEYOFF;
	}

	s16 ctr = ch->psg.env_counter;
	const u8* env = ch->psg.env_ptr + rate_pos[phase];

	switch(phase)
	{
		case 1: // attack
			ctr += env[0];
			if(ctr >= 0x00ff)
			{
				ctr = 0x00ff;
				phase++;
			}
			break;
		case 2: // decay
			ctr -= env[0];
			if(ctr <= env[1])
			{
				ctr = env[1];
				phase++;
			}
			break;
		case 3: // sustain
		case 4: // release
			ctr -= env[0];
			if(ctr <= 0)
			{
				ctr = 0;
				phase = 0;
			}
			break;
	}
	if(env[0])
	{
		ch->psg.env_counter = ctr;
		ch->psg.env_phase = phase;
		snd_psg_write_volume(ch);
	}
}

static inline void snd_psg_update_reset(struct snd_channel* ch)
{
	if((~ch->flag & SND_FLAG_KEYON) || ch->delay)
		return;

	ch->peg = ch->peg_set;
	if(ch->peg)
	{
		ch->peg_depth = ch->peg_depth_set;
		ch->peg_rate = ch->peg_rate_set;
		snd_set_peg(ch);
	}
	ch->peg_mod = 0;

	if(ch->psg.link)
		ch->last_pitch = 0xffff;
}

static inline void snd_psg_update_gate(struct snd_channel* ch)
{
	if(ch->gate_time && !(--ch->gate_time))
		ch->flag |= SND_FLAG_KEYOFF;
}

static inline void snd_psg_update_pitch(struct snd_channel* ch)
{
	static const u16 fnum[13] = {1710, 1614, 1524, 1438, 1357, 1281, 1209, 1141, 1077, 1017, 960, 906, 855};
	union
	{
		u16 pitch;
		struct
		{
			u8 note;
			u8 frac;
		};
	} p;
	u16 pitch;
	u8 octave;
	const u16* base;

	p.note = ch->transpose - 24;
	p.frac = ch->detune;
	p.pitch += ch->pitch + ch->peg_mod;

	if(p.pitch != ch->last_pitch)
	{
		ch->last_pitch = p.pitch;

		if((ch->psg.env_mode & ENV_MODE_TONE) || ch->psg.offset == 0xc0)
		{
			if(ch->psg.env_mode & ENV_MODE_2CH_FINE_TUNE && !ch->psg.link)
				p.pitch -= (s8) ch->psg.env_ptr[1];
			octave = p.note / 12;
			base = &fnum[p.note % 12];
			pitch = base[0] + (((base[1] - base[0]) * p.frac) >> 8);
			pitch >>= octave;
			snd_psg_write_freq(ch->psg.offset, pitch);
		}

		if(ch->psg.env_mode & ENV_MODE_2CH_ENABLE)
		{
			if(ch->psg.env_ptr[1] || ch->psg.link || !(ch->psg.env_mode & ENV_MODE_TONE))
			{
				if(ch->psg.link)
				{
					p.note = snd_bgm.channels[ch->psg.link - 1].transpose - 24;
					p.frac = ch->detune;
					p.pitch += snd_bgm.channels[ch->psg.link - 1].pitch + ch->peg_mod;
				}
				if(ch->psg.env_mode & ENV_MODE_2CH_FINE_TUNE)
					p.pitch += ((s8) ch->psg.env_ptr[1]) << 1;
				else
					p.note += (s8) ch->psg.env_ptr[1];

				octave = p.note / 12;
				base = &fnum[p.note % 12];
				pitch = base[0] + (((base[1] - base[0]) * p.frac) >> 8);
				pitch >>= octave;
				snd_psg_write_freq(ch->psg.offset + 0x20, pitch);
			}
		}

		if(ch->psg.env_mode & ENV_MODE_NOISE_ENABLE)
			snd_psg_write_noise(ch);
	}
}

static inline void snd_psg_update(struct snd_channel* ch)
{
	if(!(ch->flag & SND_FLAG_ENV))
		return;

	snd_psg_update_gate(ch);
	snd_psg_update_reset(ch);
	snd_update_peg(ch);
	snd_psg_update_pitch(ch);
	snd_psg_update_env(ch);

	if(ch->flag & SND_FLAG_KEYON)
	{
		if(ch->delay)
		{
			ch->delay--;
		}
		else
		{
			ch->flag &= ~(SND_FLAG_KEYON|SND_FLAG_KEYOFF);
			ch->psg.env_phase = 1;
			ch->psg.env_counter = ch->psg.env_ptr[2];
			ch->gate_time = ch->gate_time_set;
			snd_psg_write_volume(ch);
		}
	}
}

//=====================================================================
// SOUND INIT/KILL
//=====================================================================

static inline void snd_key_off(struct snd_channel* ch)
{
	if(ch->mode == SND_MODE_FM)
		snd_write_key(ch, 0);
}

static void snd_free_channel(struct snd_channel* ch)
{
	if(ch->mode == SND_MODE_PSG && ch->flag & SND_FLAG_FG)
	{
		PSG_write(ch->psg.offset + 0x1f);
		if(ch->psg.env_mode & ENV_MODE_2CH_TONE)
			PSG_write(ch->psg.offset + 0x3f);
		if(ch->psg.env_mode & ENV_MODE_NOISE_ENABLE)
			PSG_write(0xff);
	}
	else if(ch->mode == SND_MODE_FM && ch->flag & SND_FLAG_FG)
	{
		snd_write_key(ch, 0);
		take_z80();
		snd_write_fm(ch, 0x40, 127); // TL
		snd_write_fm(ch, 0x44, 127);
		snd_write_fm(ch, 0x48, 127);
		snd_write_fm(ch, 0x4c, 127);
		release_z80();
		ch->psg.link = 0;
		ch->psg.link_vol = 0;
	}
	ch->mode = SND_MODE_DISABLED;
}

void snd_assign_channel(struct snd_channel* ch, u8 arg)
{
	// Allocate channel
	if(!snd_track_se)
	{
		ch->flag &= ~(SND_FLAG_FG);
		ch->flag |= (snd_se_flag & (1 << (15 - arg))) ? 0 : SND_FLAG_FG;
	}
	else
	{
		//TODO:SE
	}
	ch->channel_id = arg;

	// Free previous data
	if(ch->mode)
	{
		snd_free_channel(ch);
	}

	// Initialize
	if(arg > 6)
	{
		ch->mode = SND_MODE_PSG;
		if(arg == 7)
			ch->psg.offset = 0x80;
		else if(arg == 8)
			ch->psg.offset = 0xa0;
		else
			ch->psg.offset = 0xc0;
		ch->psg.env_mode = 0;
		ch->psg.env_phase = 0;
		ch->psg.env_counter = 0;
		if(ch->flag & SND_FLAG_FG && ch->flag & SND_FLAG_ENV)
		{
			snd_psg_set_env(ch);
			snd_psg_write_volume(ch);
		}
	}
	else if(arg > 0)
	{
		//FM
		ch->mode = SND_MODE_FM;
		if(arg > 3)
		{
			ch->fm.part = 1;
			ch->fm.offset = arg - 4;
		}
		else
		{
			ch->fm.part = 0;
			ch->fm.offset = arg - 1;
		}
		if(ch->flag & SND_FLAG_FG && ch->flag & SND_FLAG_PATCH)
		{
			snd_fm_set_patch(ch);
			snd_fm_set_volume(ch);
			take_z80();
			snd_write_fm(ch, 0xb4, ch->pan_lfo);
			release_z80();
		}
	}
}

static void snd_kill_channel(struct snd_channel* ch)
{
	snd_free_channel(ch);
	memset(ch, 0, sizeof(*ch));
}

//=====================================================================
// SOUND COMMAND
//=====================================================================

static inline u8 arg8(struct snd_track* trk)
{
	return read_u8(trk->position++);
}

static inline u16 arg16(struct snd_track* trk)
{
	u16 ret;
	ret = read_u8(trk->position++) << 8;
	ret |= read_u8(trk->position++);
	return ret;
}

void snd_cmd_nop(struct snd_track* trk)
{
}

void snd_cmd_track_vol(struct snd_track* trk)
{
	trk->volume = snd_track_vol = arg8(trk);
}

void snd_cmd_tempo_base(struct snd_track* trk)
{
	trk->base_tempo = arg8(trk);
}

void snd_cmd_tempo(struct snd_track* trk)
{
	trk->tempo = arg8(trk);
}

void snd_cmd_jump(struct snd_track* trk)
{
	trk->position = arg16(trk);
}

void snd_cmd_pat(struct snd_track* trk)
{
	u16 dest = arg16(trk);
	trk->sub_stack[trk->sub_stack_pos++] = trk->position;
	trk->position = dest;
}

void snd_cmd_return(struct snd_track* trk)
{
	if(trk->sub_stack_pos)
	{
		trk->position = trk->sub_stack[--trk->sub_stack_pos];
	}
	else
	{
		snd_break = 1;
		trk->current_id = 0;
		for(int ch = 0; ch < 8; ch ++)
			snd_kill_channel(&trk->channels[ch]);
	}
}

void snd_cmd_repeat(struct snd_track* trk)
{
	u8 repeat_count = arg8(trk);
	u16 repeat_dest = arg16(trk);
	u8 sp = trk->repeat_stack_pos;

	if(trk->repeat_stack[sp - 1] == trk->position)
	{
		sp--;
		if(--trk->repeat_count[sp] != 0)
			trk->position = repeat_dest;
		else
			trk->repeat_stack_pos = sp;
	}
	else
	{
		trk->repeat_stack[sp] = trk->position;
		trk->repeat_count[sp] = repeat_count;
		trk->repeat_stack_pos ++;
		trk->position = repeat_dest;
	}
}

void snd_cmd_loop(struct snd_track* trk)
{
	u8 loop_count = arg8(trk);
	u16 loop_dest = arg16(trk);
	u8 sp = trk->loop_stack_pos;

	if(trk->loop_stack[sp - 1] == trk->position)
	{
		sp--;
		if(--trk->loop_count[sp] == 0)
		{
			trk->position = loop_dest;
			trk->loop_stack_pos = sp;
		}
	}
	else
	{
		trk->loop_stack[sp] = trk->position;
		trk->loop_count[sp] = loop_count;
		trk->loop_stack_pos ++;
	}
}

void snd_cmd_init(struct snd_track* trk)
{
	u8 current_part = 1;
	u8 mask = arg8(trk);

	struct snd_channel *ch = &trk->channels[0];

	while(mask)
	{
		if(mask & 0x80 && current_part < 7)
		{
			snd_assign_channel(ch, current_part++);
		}
		mask <<= 1;
		ch++;
	}
}

void snd_cmd_pcm(struct snd_track* trk)
{
	trk->position++;
}

void snd_cmd_comm(struct snd_track* trk)
{
	trk->position++;
}

void snd_cmd_fm3(struct snd_track* trk)
{
	//static const u16 transpose[4] = {0, 0x600>>1, 0x7cc>>1, 0x980>>1};
	static const u16 transpose[5] = {0, 0x600<<0, 0x7cc<<0, 0x980<<0, 0x7cc<<0};
	u8 flag = arg8(trk);

	take_z80();
	snd_write_fm_common(0x27, flag);
	release_z80();
	if(flag & 0xc0)
	{
		union
		{
			u16 pitch;
			struct
			{
				u8 note;
				u8 frac;
			};
		} p, p2;

		p.note = arg8(trk);
		p.frac = 0;

		for(int i = 0; i < 3; i++)
		{
			u8 octave;
			const u16* base;

			u16 tp = transpose[arg8(trk)];
			p2.pitch = p.pitch + (tp & 0xff);

			octave = p2.note / 12;
			base = &snd_fm_fnum_table[(p.note % 12) + (tp >> 8)];

			p2.pitch = base[0] + (((base[1] - base[0]) * p2.frac) >> 8) + ((octave & 7) << 11);

			take_z80();
			snd_write_fm_common(0xac + i, p2.note);
			snd_write_fm_common(0xa8 + i, p2.frac);
			release_z80();
		}
	}


}
//=====================================================================

void snd_cmd_nop_ch(struct snd_channel* ch, u8 arg)
{
}

void snd_cmd_key_on(struct snd_channel* ch, u8 arg)
{
	if(arg == 0xff)
	{
		if(ch->flag & SND_FLAG_FG)
			snd_key_off(ch);
		ch->flag |= SND_FLAG_KEYOFF;
	}
	else
	{
		if(ch->flag & SND_FLAG_FG && ch->mode)
		{
			if(!ch->legato)
				snd_key_off(ch);
			else
				ch->legato--;
			ch->flag |= SND_FLAG_KEYON;
		}
		else
		{
			if(ch->legato)
				ch->legato--;
		}
		ch->note = arg;
	}
}

void snd_cmd_patch(struct snd_channel* ch, u8 arg)
{
	// Optimize patch writes to save some CPU load
	u8 prev_flags = ch->flag;
	u8 prev_patch = ch->patch;
	ch->patch = arg;
	ch->flag |= SND_FLAG_PATCH;
	if(ch->flag & SND_FLAG_FG && ch->mode == SND_MODE_FM
	   && (!(prev_flags & SND_FLAG_PATCH) || prev_patch != arg))
		snd_fm_set_patch(ch);
}

void snd_cmd_env(struct snd_channel* ch, u8 arg)
{
	ch->env = arg;
	ch->flag |= SND_FLAG_ENV;
	if(ch->flag & SND_FLAG_FG && ch->mode == SND_MODE_PSG)
		snd_psg_set_env(ch);
}

void snd_cmd_volume(struct snd_channel* ch, u8 arg)
{
	ch->volume = (arg * snd_track_vol) >> 8;
	if(ch->flag & SND_FLAG_FG)
	{
		if (ch->mode == SND_MODE_FM)
			snd_fm_set_volume(ch);
	}
}

void snd_cmd_transpose(struct snd_channel* ch, u8 arg)
{
	ch->transpose = arg;
}

void snd_cmd_detune(struct snd_channel* ch, u8 arg)
{
	ch->detune = arg;
}

void snd_cmd_peg(struct snd_channel* ch, u8 arg)
{
	ch->peg_set = arg;
}

void snd_cmd_peg_rate(struct snd_channel* ch, u8 arg)
{
	ch->peg_rate_set = arg;
}

void snd_cmd_peg_depth(struct snd_channel* ch, u8 arg)
{
	ch->peg_depth_set = arg;
}

void snd_cmd_legato(struct snd_channel* ch, u8 arg)
{
	ch->legato = arg;
}

void snd_cmd_gate_time(struct snd_channel* ch, u8 arg)
{
	ch->gate_time_set = arg;
}

void snd_cmd_delay(struct snd_channel* ch, u8 arg)
{
//	ch->delay_set = arg;
	ch->delay = arg;
}

void snd_cmd_lfo(struct snd_channel* ch, u8 arg)
{
	ch->lfo = arg;
	ch->flag |= SND_FLAG_LFO;
}

void snd_cmd_pan(struct snd_channel* ch, u8 arg)
{
	ch->pan_lfo = (ch->pan_lfo & 0x3f) | (arg & 0xc0);
	if(ch->flag & SND_FLAG_FG && ch->mode == SND_MODE_FM)
	{
		take_z80();
		snd_write_fm(ch, 0xb4, ch->pan_lfo);
		release_z80();
	}
}

void snd_cmd_link(struct snd_channel* ch, u8 arg)
{
	if(ch->mode == SND_MODE_PSG)
	{
		ch->psg.link = arg;
		ch->last_pitch = 0xffff;
	}
}

void snd_cmd_link_vol(struct snd_channel* ch, u8 arg)
{
	if(ch->mode == SND_MODE_PSG)
	{
		ch->psg.link_vol = arg;
	}
}

static const void* snd_cmd_table[32] =
{
/* 00 */ snd_cmd_nop,
/* 01 */ snd_cmd_track_vol,
/* 02 */ snd_cmd_tempo_base,
/* 03 */ snd_cmd_tempo,
/* 04 */ snd_cmd_pat,
/* 05 */ snd_cmd_return,
/* 06 */ snd_cmd_key_on,
/* 07 */ snd_cmd_patch,
/* 08 */ snd_cmd_volume,
/* 09 */ snd_cmd_jump,
/* 0a */ snd_cmd_link, // ctr: PSG link mode
/* 0b */ snd_cmd_repeat,
/* 0c */ snd_cmd_loop,
/* 0d */ snd_cmd_transpose,
/* 0e */ snd_cmd_detune,
/* 0f */ snd_cmd_peg,
/* 10 */ snd_cmd_peg_rate,
/* 11 */ snd_cmd_legato,
/* 12 */ snd_cmd_gate_time,
/* 13 */ snd_cmd_peg_depth,
/* 14 */ snd_cmd_env, // ctr: set PSG envelope
/* 15 */ snd_cmd_delay,
/* 16 */ snd_cmd_lfo, // lfo
/* 17 */ snd_cmd_pan, // pan
/* 18 */ snd_assign_channel, // ctr: Initialize channel
/* 19 */ snd_cmd_comm, // communication byte
/* 1a */ snd_cmd_init,
/* 1b */ snd_cmd_pcm, // TODO: ADPCM request
/* 1c */ snd_cmd_fm3, // fm3 special mode
/* 1d */ snd_cmd_link_vol, // ctr: link mode attenuation
/* 1e */ snd_cmd_nop, // *** UNUSED ***
/* 1f */ snd_cmd_nop, // *** UNUSED ***
};

//=====================================================================
// COMMAND UPDATE
//=====================================================================
static void snd_read_command(struct snd_track* trk)
{
	snd_break = 0;
	while(!snd_break)
	{
		u8 cmd_byte = arg8(trk);
		snd_break = cmd_byte & 0x20;
		if(cmd_byte & 0x80)
		{
			const snd_tcmd_ptr_t cmd_ptr = snd_cmd_table[cmd_byte & 0x1f];
			cmd_ptr(trk);
		}
		else
		{
			struct snd_channel* ch = &trk->channels[0];
			const snd_vcmd_ptr_t cmd_ptr = snd_cmd_table[cmd_byte & 0x1f];
			u8 mask = arg8(trk);
			if(cmd_byte & 0x40)
			{
				u8 val = arg8(trk);
				while(mask)
				{
					if(mask & 0x80)
						cmd_ptr(ch, val);
					ch++;
					mask <<= 1;
				}
			}
			else
			{
				while(mask)
				{
					if(mask & 0x80)
					{
						//KDebug_AlertNumber(ch);
						cmd_ptr(ch, arg8(trk));
					}
					ch++;
					mask <<= 1;
				}
			}
		}
	}
}

//=====================================================================
// TRACK UPDATE
//=====================================================================
static inline void snd_update_track(struct snd_track* trk, u8 se)
{
	snd_track_se = se;
	if(trk->request)
	{
		if(trk->request == 0xff)
		{
			snd_bgm_fade.ctr += SND_FADE_RATE;
			if(snd_bgm_fade.ctr > 0x3f00)
				trk->request = 0xfe;
		}
		if(!se && trk->request != 0xff)
		{
			snd_bgm_fade.ctr = 0;

			for(int ch = 0; ch < 8; ch ++)
				snd_kill_channel(&trk->channels[ch]);

			if(trk->request == 0xfe)
			{
				// stop request
				trk->current_id = 0;
			}
			else
			{
				trk->update_time = 1;
				trk->base_tempo = 1;
				trk->tempo = 6;
				trk->position = read_u16(read_u16(0) + (trk->request << 1));
				trk->volume = 255;
				trk->sub_stack_pos = 0;
				trk->repeat_stack_pos = 0;
				trk->loop_stack_pos = 0;
				trk->current_id = trk->request + 1;
				//KDebug_Alert("Starting BGM track");
				//KDebug_AlertNumber(trk->position);
				take_z80();
				YM2612_writeReg(0, 0x2b, 0x00); // dac disable
				YM2612_writeReg(0, 0x27, 0x00); // ch3 special disable
				release_z80();
			}
			trk->request = 0;
		}
	}

	if(trk->current_id)
	{
		if(!se)
		{
			snd_fm_attenuate = SND_SE_FM_ATTENUATE + snd_bgm_fade.ctr_hi;
			snd_psg_attenuate = SND_SE_PSG_ATTENUATE + snd_bgm_fade.ctr_hi;
			if(snd_bgm_fade.ctr_hi)
			{
				struct snd_channel* ch = &trk->channels[0];
				while(ch < &trk->channels[8])
				{
					if(ch->flag & SND_FLAG_FG)
					{
						switch(ch->mode)
						{
							case SND_MODE_FM:
								snd_fm_write_volume(ch);
								break;
							case SND_MODE_PSG:
								snd_psg_write_volume(ch);
								break;
						}
					}
					ch++;
				}
			}
		}
		else
		{
			snd_fm_attenuate = SND_SE_FM_ATTENUATE;
			snd_psg_attenuate = SND_SE_PSG_ATTENUATE;
		}
		snd_track_vol = trk->volume;

		trk->update_time--;
		if(trk->update_time == 0)
		{
			snd_read_command(trk);
			trk->update_time = trk->base_tempo * trk->tempo;
		}

		struct snd_channel* ch = &trk->channels[0];
		while(ch < &trk->channels[8])
		{
			if(ch->flag & SND_FLAG_FG)
			{
				switch(ch->mode)
				{
					case SND_MODE_FM:
						snd_fm_update(ch);
						break;
					case SND_MODE_PSG:
						snd_psg_update(ch);
						break;
				}
			}
			ch++;
		}
	}
}

static const u16 snd_fm_fnum_table[21] = {
	644, 681, 722, 765, 810, 858, 910, 964, 1021, 1081, 1146, 1214,
	1288,1364,1445,1531,1622,1719,1821,1929,2044};
static const s8 snd_psg_vol_table[128] = {
	61,60,60,
	59,59,59,58,58,58,57,57,
	56,56,56,55,55,55,54,54,
	53,53,53,52,52,52,51,51,
	50,50,50,49,49,49,48,48,
	47,47,47,46,46,46,45,45,
	44,44,44,43,43,43,42,42,
	41,41,41,40,40,40,39,39,
	38,38,38,37,37,37,36,36,
	35,35,35,34,34,34,33,33,
	32,32,32,31,31,31,30,30,
	29,29,29,28,28,28,27,27,
	26,26,26,25,25,25,24,24,
	23,23,23,22,22,22,21,21,
	20,20,20,19,19,19,18,18,
	17,17,17,16,16,16,15,15,
	15,15,15,15,15
};
