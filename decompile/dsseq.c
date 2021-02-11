/*
 * Dragon Spirit sound decompiler
 * By ctr 2021-02-11
 */

// use tracker style notes (A-4 vs An4, A#4 vs As4)
//#define TRACKER_NOTE 1

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <math.h>

    uint8_t* source;

enum {
    DATA_HEADER = 0x01,
    DATA_SONGTABLE = 0x02,
    DATA_SONG = 0x03,
    DATA_WAVETABLE = 0x04,
    DATA_WAVE = 0x05,
    DATA_PITCHENVTABLE = 0x06,
    DATA_PITCHENV = 0x07,
    DATA_ENVTABLE = 0x08,
    DATA_ENV = 0x09,
    DATA_PANENVTABLE = 0x0a,
    DATA_PANENV = 0x0b,
    DATA_LFO = 0x0c,
    DATA_MACROMAP = 0x0d,
    DATA_DRIVER = 0x0e,
    DATA_PAD = 0x0f,

    DATA_DEFINED = 0x10,
    DATA_PARSED = 0x20, // Data has an associated string
    DATA_SEPARATOR = 0x40, // this indicates the first entry in a table.
    LABEL_DEFINED = 0x80 // Data has an associated label
};

const char* DataNames[0x10] =
{
    "Unknown","Header","Song table","Song data",
    "Wave table","Wave data","Pitch env. table","Pitch env. data",
    "Envelope table","Envelope data","Pan env. table","Pan env. data",
    "LFO parameters","Macro note maps","Program code","Padding"
};

enum {
    LABEL_SUB = 0,
    LABEL_REPEAT = 1,
    LABEL_LOOP = 2,
    LABEL_JMP = 3,
    LABEL_COND = 4,
};

const char* label_types[5] =
{
    "sub","rept","loop","jmp","cond"
};

enum {
	PRINT_ADDR = 1,
	PRINT_HEX = 2,
	EXPAND_RESTS = 4,
	AGGRESSIVE_PADDING = 8,
	FM_TRANSPOSE = 16,
	DRIVER_NA = 32,
	DRIVER_S1 = 64,
	DRIVER_S1OLD = 128
};
	int options;
	
    uint8_t* source_flag;
    char** source_labels;
    char** source_strings;
    int32_t sourcefile_size;

    int   ignore_unreferenced; // 1 =ignore unreferenced song data....
    int   readmode; // 0 = Read song, 1 = Read whole file.

    char  s_addr[10], s_hexdata[200], s_humandata[260];
    int   hexdata_cnt, humandata_cnt;

    int   songstack[2048];
    int   stackpos;

    uint32_t   startaddr;
    int   baseaddr; // this is just startaddr&0xff0000
    int   songpos;
    int   parsed_songpos;
    uint32_t   posoffset;
	uint32_t   posoffset2;
    int   parsedbytes;

    int   label_type_cnt[5];
    uint8_t* label_prefix;


    char  tempstr[16000000];
    uint32_t   tempstr_counter;

// Used by the unreferenced song finder to identify unused music.
// If we find an "init channel" or "subsong" command, this is set.
    int   chflag=0;

// Set to indicate end of a song.
    int   endflag=0;

    int   chtranspose[8];
    int   s_tempo;
    int   s_speed;

    uint32_t drv_start;
    uint32_t drv_end;


    uint32_t songtable[0x800];
    uint16_t subsongid[0x800];
    uint8_t **songmsgs[0x800];
    uint8_t *songmsg;



    uint32_t songcount;
    // dunno what the max amount of waves is.
    //uint32_t wavetable[0x800];
    uint32_t wavecount;
    //uint32_t pitchtable[0x100];
    uint32_t pitchcount;
    //uint32_t envtable[0x100];
    uint32_t envcount;
    //uint32_t pantable[0x100];
    uint32_t pancount;
    uint32_t lfocount;
    uint32_t macrocount;

enum MCUType {
    MCU_UNIDENTIFIED = 0,
    MCU_C74 =1, // M37702 System22
    MCU_C75 =1, // M37702 NB-1/NB-2
    MCU_C76 =2, // M37702 System11
    MCU_SS22=3,// M37710S4 SystemSuper22
    MCU_ND  =4,  // H8/3002 ND-1
    MCU_S12 =5, // H8/3002 System12
    MCU_S23 =5, // H8/3002 System23
    MCU_MAX
};

const char* MCUNames[MCU_MAX] =
{
    "Unidentifed","C74/C75 (System22/NB)","C76 (System11)","M37710 (SystemSuper22)","H8/3002 (ND-1)","H8/3002 (System12/23)",//"H8/3002 (System23)"
};

    enum MCUType mcu_type;

#ifdef TRACKER_NOTE
const char* NoteNames[12] =
{
    "A-","A#","B-","C-","C#","D-","D#","E-","F-","F#","G-","G#"
};
#else
// taken from "leaked" sources
const char* NoteNames[12] =
{
    "An","As","Bn","Cn","Cs","Dn","Ds","En","Fn","Fs","Gn","Gs"
};
#endif

const char MCUVerSearch_H8[] = "namco ltd.;System";
const char* MCUVerSearch_Quattro[5] =
{
    "Q00","Q01","Q02","Quattro","QX"
};

/*
char* CmdName[64] =
{
	"NOP","TVOL","TEMPO","SPEED","CALL","RET","FRQ","WAVE",
	"VOL","JMP","REPT","LOOP","TRS","DTN","PIT","PITRAT",
	"LEG","GTM","PITDEP","ENV","DEL","LFO","PAN","PANENV",
	"C18","T19","NOP","T1A","SE","FM","PCM","SMPV",
	"INIT0","INIT8","PTA","BANK","INIT","C25","C26","C27",
	"C28","C29","C2A","C2B","C2C","C2D","C2E","C2F",
	"C30","C31","C32","C33","C34","C35","C36","C37",
	"C38","C39","C3A","C3B","C3C","C3D","C3E","C3F"
};
*/

enum ArgType {
    ARG_DECIMAL, // Preferred for plain values
    ARG_SIGNED_DECIMAL, // Preferred for transpose
    ARG_HEX, // Preferred for entries
    ARG_HEX_WORD, // Preferred for sample IDs
    ARG_REGISTER,
    ARG_REGISTER_IND,
    ARG_NOTE,
    ARG_ADDRESS,
    ARG_ADDRWORD,
    ARG_LONG,
    ARG_EMPTY,
    ARG_EMPTY_NOTE,
    ARG_NOTE_CUT,
	ARG_BINARY,
	ARG_PANNING
};

char* CmdName[64] =
{
	//0   1        2     3        4     5      6      7
	"NOP","TVOL","TEMPO","SPEED","CALL","RET","FRQ","INS",
	"VOL","JUMP","END","REPT","LOOP","TRS","DTN","PIT",
	"PITRAT","LEG","GTM","PITDEP","ENV","DEL","WSG","DAC",
	"LFO","PAN","C1A","COMM","SE","FM","PCM","SMPV",
	"INIT","PCM","PTA","BANK","INIT","C25","C26","C27",
	"C28","C29","C2A","C2B","C2C","C2D","C2E","C2F",
	"C30","C31","C32","C33","C34","C35","C36","C37",
	"C38","C39","C3A","C3B","C3C","C3D","C3E","C3F"
};

enum ArgType trkvar_types[0x23] =
{
    ARG_DECIMAL,ARG_DECIMAL,ARG_DECIMAL,ARG_DECIMAL,ARG_DECIMAL,ARG_DECIMAL,ARG_NOTE,ARG_DECIMAL,
    ARG_DECIMAL,ARG_DECIMAL,ARG_DECIMAL,ARG_DECIMAL,ARG_DECIMAL,ARG_SIGNED_DECIMAL,ARG_DECIMAL,ARG_DECIMAL,
    ARG_DECIMAL,ARG_DECIMAL,ARG_DECIMAL,ARG_DECIMAL,ARG_DECIMAL,ARG_DECIMAL,ARG_DECIMAL,ARG_DECIMAL,
    ARG_DECIMAL,ARG_PANNING,ARG_DECIMAL,ARG_DECIMAL,ARG_DECIMAL,ARG_DECIMAL,ARG_DECIMAL,ARG_DECIMAL,
	ARG_BINARY,ARG_HEX,ARG_DECIMAL
};

char* note_to_string(uint8_t index)
{
	static char s[8];
	
    if(index == 0xff)
		#ifdef TRACKER_NOTE
        sprintf(s,"===");
		#else
		sprintf(s,"Q__");
		#endif
	else
	{
		if(options & FM_TRANSPOSE)
			index += 4;
			
		int note = index%12;
		int oct = (index-3)/12;

		sprintf(s,"%s%d",NoteNames[note],oct);
	}

    return s;
}

// http://www.hackersdelight.org/hdcodetxt/crc.c.txt
uint32_t crc32(uint8_t *message, uint32_t length)
{
   int i, j, l;
   uint32_t byte, crc, mask;

   i = 0;
   crc = 0xFFFFFFFF;
   for(l=0;l<length;l++) {
      byte = message[i];            // Get next byte.
      crc = crc ^ byte;
      for (j = 7; j >= 0; j--) {    // Do eight times.
         mask = -(crc & 1);
         crc = (crc >> 1) ^ (0xEDB88320 & mask);
      }
      i = i + 1;
   }
   return ~crc;
}

void start_line()
{
    sprintf(s_addr,"%06x:",songpos+posoffset);

    *s_hexdata=0;
    *s_humandata=0;
    hexdata_cnt=0;
    humandata_cnt=0;
}

void end_line()
{
    printf("%-9s %-39s %s \n",s_addr,s_hexdata,s_humandata);
    *s_addr=0;
}

int read_pos(uint8_t* d)
{
	uint16_t addr = (d[1]<<0) | (d[0]<<8);
	if(options & DRIVER_NA)
		addr = (d[0]<<0) | (d[1]<<8);
    return addr + (songpos&0xf0000) + posoffset2; // bank is hardcoded for now
}
uint16_t read_word(uint8_t* d)
{
    //return ((d[1]<<8) | (d[0]<<0));
    return ((d[0]<<8) | (d[1]<<0));
}

uint16_t read_word_be(uint8_t* d)
{
    return ((d[0]<<8) | (d[1]<<0));
}

/*
 Flags:
 0: -
 1: Leftpad
 2: Comma
 3: Leftpad and comma
*/
char* arg(int flags, enum ArgType type, uint32_t data)
{
    static char temp[64];
    static char temp2[64];

    switch(type)
    {
    case ARG_BINARY:
        sprintf(temp,"%%%d%d%d%d%d%d%d%d",
		(data>>7)&1,
		(data>>6)&1,
		(data>>5)&1,
		(data>>4)&1,
		(data>>3)&1,
		(data>>2)&1,
		(data>>1)&1,
		(data>>0)&1
		);
		break;
    case ARG_DECIMAL:
        sprintf(temp,"%03u",data);break;
    case ARG_SIGNED_DECIMAL:
        sprintf(temp,"%03d",(int8_t)data);break;
	case ARG_PANNING:
		switch(data & 0xc0)
		{
			case 0x40: sprintf(temp, "L__"); break;
			case 0x80: sprintf(temp, "__R"); break;
			case 0xc0: sprintf(temp, "_C_"); break;
			default: sprintf(temp, "000"); break;
		}
		break;
    case ARG_HEX:
    default:
        sprintf(temp,"$%02x",(uint8_t)data);break;
    case ARG_HEX_WORD:
        sprintf(temp,"$%04x",(uint16_t)data);break;
    case ARG_REGISTER:
        sprintf(temp,"r%02x",data);break;
    case ARG_REGISTER_IND:
        sprintf(temp,"r%02xi",data);break;
    case ARG_NOTE:
        sprintf(temp,"%s",note_to_string(data));break;
    case ARG_ADDRESS:
    case ARG_ADDRWORD:
        if(source_flag[data] & LABEL_DEFINED)
            sprintf(temp,source_labels[data]);
        else if(type==ARG_ADDRESS)
            sprintf(temp,"$%06x",data+posoffset);
        else if(type==ARG_ADDRWORD)
            sprintf(temp,"$%04x",data);
        break;
    case ARG_LONG:
        sprintf(temp,"$%06x",data);
        break;
	#ifdef TRACKER_NOTE
    case ARG_EMPTY:
        sprintf(temp,"...");break;
    case ARG_EMPTY_NOTE:
        sprintf(temp,"...");break;
    case ARG_NOTE_CUT:
        sprintf(temp,"===");break;
	#else
    case ARG_EMPTY:
        sprintf(temp,"___");break;
    case ARG_EMPTY_NOTE:
        sprintf(temp,"___");break;
    case ARG_NOTE_CUT:
        sprintf(temp,"Q__");break;
	#endif
    }

    switch(flags&3)
    {
    case 0:
        sprintf(temp2,"%s",temp);break;
    case 1:
        sprintf(temp2,"%s,",temp);break;
    case 2:
        sprintf(temp2,"%3s",temp);break;
    case 3:
        sprintf(temp2,"%3s,",temp);break;
    }

    if(flags&4)
        sprintf(temp2+strlen(temp2)," ");

    return temp2;
}

void print_cmd(uint8_t* data)
{
    humandata_cnt = sprintf(s_humandata,"%-12s",data);
}


void print_arg(int flags, enum ArgType type, uint32_t data)
{
    humandata_cnt += sprintf(s_humandata+humandata_cnt,"%s",arg(flags,type,data));
}

// use this for the first line
void set_string(uint32_t addr,uint8_t* data)
{
    strcpy(tempstr+tempstr_counter,data);
    source_strings[addr] = tempstr+tempstr_counter;
    tempstr_counter += strlen(data)+2;
    source_flag[addr] |= DATA_PARSED;
}

// use this for second line and so on
void set_string2(uint8_t* data)
{
	tempstr_counter--;
    strcpy(tempstr+tempstr_counter,data);
    tempstr_counter += strlen(data)+2;
}


char* set_label(uint32_t addr,uint8_t* data)
{
    if(source_flag[addr] & LABEL_DEFINED)
    {
        //printf("Label at %06x '%s' NOT redefined as '%s'\n",addr,source_labels[addr],data);
    }
    else
    {
        strcpy(tempstr+tempstr_counter,data);
        source_labels[addr] = tempstr+tempstr_counter;
        tempstr_counter += strlen(data)+1;
        source_flag[addr] |= LABEL_DEFINED;
    }

    return source_labels[addr];
}

void set_songlabel(uint32_t addr,int labeltype)
{
    if(readmode)
        return; // prevent crash

    char temp[64];
    char* temp2;

    sprintf(temp,"%s_%s%03d",label_prefix,label_types[labeltype],label_type_cnt[labeltype]);
    temp2 = set_label(addr,temp);

    if(strcmp(temp,temp2) == 0)
    {
        label_type_cnt[labeltype] ++;
    }

}
void GetSongOffset() {

    //uint32_t startaddr2 = 0x10000;
    uint32_t startaddr2 = 0x00000;
    uint32_t posoffset2 = 0;

    if(!startaddr)
        startaddr = startaddr2;
    if(!posoffset)
        posoffset = posoffset2;
}

int w_s2chnvar(uint8_t* d, int same, enum ArgType type)
{
    uint8_t* b = d, *c;

    uint8_t channel_mask = *d;
    d++;

    int i;

    for(i=0;i<8;i++)
    {
        //printf("mask=%02x\n",channel_mask);
        if (channel_mask&0x80)
        {
            print_arg(3,type,*d);

            if(!same)
            {
                d++;
            }
        }
        else
            print_arg(3,ARG_EMPTY,0);

        channel_mask<<=1;
    }

    c = strrchr(s_humandata,',');   // get rid of last comma
    if(c)
        *c = ' ';

    if(same)
    {
        d++;
    }

    return d-b;
}

void define_data(uint32_t pos, uint32_t len, uint8_t flags)
{
    int i;
    for(i=pos;i<pos+len;i++)
        *(source_flag+i) |= flags|DATA_DEFINED;
}

#define CHNDEF humandata_cnt += sprintf(s_humandata,"ChnVar %02x,  ", chnvar)
#define TRKDEF humandata_cnt += sprintf(s_humandata,"SongVar %02x, ", trkvar);

void read_cmd()
{
    parsed_songpos=-1;

    if(source_flag[songpos] & DATA_DEFINED)
    {
        if(stackpos && source_flag[songpos] & DATA_SONG)
        {
            //printf("%02x\n",source_flag[songpos]);
            songpos=songstack[stackpos--];
            sprintf(s_addr,"%06x:",songpos+posoffset);
            //printf("Popping address %06x\n",songpos);
        }
        else
        {
            endflag=1;
            return;
        }
    }
    source_flag[songpos] |= (DATA_DEFINED|DATA_SONG);

    parsed_songpos=songpos;
    int nextcmd = 0;
    int cmdlen = 0;
    int i;

    uint16_t tempword;

    uint8_t cmd = source[songpos];
    uint8_t trkvar= source[songpos+1]&0x7f;
    uint8_t chnvar= source[songpos+2]&0x7f;
    sprintf(s_humandata,"Unknown");

	// hack...
	/*
	if(options & DRIVER_S1OLD)
	{
		if(cmd == 0x0b)
			cmd = 0x0a;
		else if(cmd == 0x0c)
			cmd = 0x0b;
	}
	*/

    if(cmd<0x80)
    {
        switch(cmd&0x3f)
        {
        case 0x00: case 0x1a:
            print_cmd("Nop");
            cmdlen=1;
            break;
        case 0x06: case 0x07: case 0x08: case 0x0d: case 0x0e:
		case 0x0f: case 0x10: case 0x11: case 0x12: case 0x13: case 0x14:
		case 0x15: case 0x16: case 0x17: case 0x18: case 0x1f: case 0x22: case 0x24:
            print_cmd(CmdName[cmd&0x3f]);
            cmdlen = 1+w_s2chnvar(source+songpos+1, cmd&0x40, trkvar_types[cmd&0x3f]);
			if((cmd&0x3f) ==0x06)
				humandata_cnt += sprintf(s_humandata+humandata_cnt,"; ");
            break;
		case 0x20: case 0x21:
			if(options & DRIVER_NA)
			{
				print_cmd("VOICE");
				cmdlen = 1+w_s2chnvar(source+songpos+1, cmd&0x40, ARG_DECIMAL);
				break;
			}
		case 0x01: case 0x02: case 0x03: case 0x1b:
            print_cmd(CmdName[cmd&0x3f]);
            print_arg(0,trkvar_types[cmd&0x3f],*(source+songpos+1));
            cmdlen=2;
            break;
        case 0x01c: case 0x1d: case 0x1e: case 0x23:
            print_cmd(CmdName[cmd&0x3f]);
            chflag=1;
            print_arg(7,ARG_HEX,*(source+songpos+1));
            print_arg(0,ARG_HEX,*(source+songpos+2));
            cmdlen = 3;
            break;
        case 0x09:
            cmdlen=3;
            nextcmd=read_pos(source+songpos+1);
            print_cmd(CmdName[cmd&0x3f]);//        $%06x", read_pos(source+songpos+1)+posoffset);
            set_songlabel(read_pos(source+songpos+1),LABEL_JMP);
            print_arg(0,ARG_ADDRESS,read_pos(source+songpos+1));
            break;
        case 0x04:
            cmdlen=3;
            stackpos++;songstack[stackpos]=songpos+cmdlen;
            print_cmd(CmdName[cmd&0x3f]);//  $%06x", read_pos(source+songpos+1)+posoffset);
            set_songlabel(read_pos(source+songpos+1),LABEL_SUB);
            print_arg(0,ARG_ADDRESS,read_pos(source+songpos+1));
            nextcmd=read_pos(source+songpos+1);
            break;
        case 0x0b:
            cmdlen=4;
            stackpos++;songstack[stackpos]=songpos+cmdlen;
            print_cmd(CmdName[cmd&0x3f]);//        $%02d, $%06x", *(source+songpos+1), read_pos(source+songpos+2)+posoffset);
            print_arg(7,ARG_HEX,*(source+songpos+1));
            set_songlabel(read_pos(source+songpos+2),LABEL_REPEAT);
            print_arg(0,ARG_ADDRESS,read_pos(source+songpos+2));
            nextcmd=read_pos(source+songpos+2);
            break;
        case 0x0c:
            cmdlen=4;
            stackpos++;songstack[stackpos]=read_pos(source+songpos+2);
            print_cmd(CmdName[cmd&0x3f]);//       $%02d, $%06x", *(source+songpos+1), read_pos(source+songpos+2)+posoffset);
            print_arg(7,ARG_HEX,*(source+songpos+1));
            set_songlabel(read_pos(source+songpos+2),LABEL_LOOP);
            print_arg(0,ARG_ADDRESS,read_pos(source+songpos+2));
            nextcmd=songpos+cmdlen;
            break;
        case 0x05:
            cmdlen=1;
            print_cmd(CmdName[cmd&0x3f]);
            if(stackpos)
                nextcmd=songstack[stackpos--];
            else
                endflag=1;
            break;
		case 0x19:
			if(options & DRIVER_S1OLD)
			{
				print_cmd(CmdName[cmd&0x3f]);
				cmdlen = 1+w_s2chnvar(source+songpos+1, cmd&0x40, trkvar_types[cmd&0x3f]);
				break;
			}
			else if(options & DRIVER_S1)
			{
				print_cmd(CmdName[cmd&0x3f]);
				chflag=1;
				print_arg(7,ARG_HEX,*(source+songpos+1));
				print_arg(0,ARG_HEX,*(source+songpos+2));
				cmdlen = 3;
				break;
			}
        default:
			print_cmd(CmdName[cmd&0x3f]);
			sprintf(s_humandata,"; Unimplemented command $%02x",cmd);
			fprintf(stderr,"Read unknown command %02x at %06x\n",cmd,songpos);
			cmdlen=13;
			endflag=1;
			break;
        }
    }
    else
    { //                     0123456789012

		if(options & EXPAND_RESTS)
		{	
			humandata_cnt=0;
			print_cmd("FRQ");
			for(i=0;i<7;i++)
				print_arg(3, ARG_EMPTY_NOTE, 0);
			print_arg(2, ARG_EMPTY_NOTE, 0);
			
			sprintf(s_humandata+humandata_cnt," ;");
			
			set_string(parsed_songpos,s_humandata);
			parsed_songpos=-1;

			while(cmd > 0x80)
			{
				humandata_cnt=0;
				print_cmd("FRQ");
				for(i=0;i<7;i++)
					print_arg(3, ARG_EMPTY_NOTE, 0);
				print_arg(2, ARG_EMPTY_NOTE, 0);
				sprintf(s_humandata+humandata_cnt," ;");
				cmd--;
				set_string2(s_humandata);
			}
			
		}
		else
		{
			print_cmd("REST");//        %d",(cmd&0x7f)+1);
			print_arg(2,ARG_DECIMAL, (cmd&0x7f)+1);
		}
        cmdlen=1;
    }

    //int i;

    int cmdlen2 = cmdlen;
    if(cmdlen2 > 13)
        cmdlen2 = 13;

    if(readmode)
    {
        for(i=0;i<cmdlen2;i++)
        {
            hexdata_cnt += sprintf(s_hexdata+hexdata_cnt,"%02x ",*(source+songpos+i));
        }
    }

    define_data(parsed_songpos,cmdlen,DATA_SONG);
    parsedbytes += cmdlen;

    songpos+=cmdlen;
    if(nextcmd)
        songpos = nextcmd;
    nextcmd=0;
}



void read_song()
{
    s_tempo=0x50;
    s_speed=0x1e;

    int i;
    for(i=0;i<8;i++)
        chtranspose[i]=0;

    memset(source_flag,0,0x80000);

    stackpos=0;
    while(!endflag)
    {
        start_line();
        read_cmd();
        //if(source_flag[songpos] == 0x01)
        //    endflag=01;
        end_line();
    }
}

void read_table(uint32_t pos, int count, int mode)
{
    if(count == 0)
        return;

    humandata_cnt=0;

    static char print_word[] = "ADDR";
    static char print_song[] = "ADDR";

    char* printstr = mode ? print_song : print_word;

    print_cmd(printstr);

    int i=0;
    uint32_t oldpos=pos;

    while(1)
    {
        if(mode)
        {
            print_arg(5,ARG_ADDRESS,read_pos(source+pos));
            pos+=3;
        }
        else
        {
            print_arg(5,ARG_ADDRWORD,read_word(source+pos)+ baseaddr);
            pos+=2;
        }

        i++;
        if((i%count == 0) || (source_flag[pos] & DATA_SEPARATOR))
        {

            char *c = strrchr(s_humandata,',');   // get rid of last comma
            if(c)
                *c = ' ';
            set_string(oldpos,s_humandata);
            oldpos=pos;

            if(source_flag[pos] & DATA_SEPARATOR)
            {
                printf("breaking table at %06x\n",pos);
                break;
            }
            else
                print_cmd(printstr);
        }
    }

    return;
}


int read_data(uint32_t pos, int count, int mode, int length)
{
    if(count == 0)
        return;

    humandata_cnt=0;

    static char print_word[] = ".word";
    static char print_byte[] = ".byt";

    char* printstr = mode ? print_byte : print_word;

    print_cmd(printstr);

    int i=0;
    uint32_t oldpos=pos;
    //printf("sequence started at %06x\n",pos);

    while(1)
    {
        if(mode == 2)
        {
			if(*(source+pos) < 0xfd)
				print_arg(5,ARG_DECIMAL,*(source+pos));
			else
				print_arg(5,ARG_HEX,*(source+pos));
            pos++;
        }
		else if(mode)
        {
            print_arg(5,ARG_HEX,*(source+pos));
            pos++;
        }
        else
        {
            print_arg(5,ARG_HEX_WORD,read_word(source+pos));
            pos+=2;
        }

        i++;
        if((i%count == 0) ||  i==length || (source_flag[pos] & DATA_SEPARATOR))
        {

            char *c = strrchr(s_humandata,',');   // get rid of last comma
            if(c)
                *c = ' ';
            set_string(oldpos,s_humandata);
            oldpos=pos;

            if(i==length || (source_flag[pos] & DATA_SEPARATOR))
            {
                //if(source_flag[pos] & DATA_SEPARATOR)
                //    printf("sequence ended (data separator reached) %06x\n",pos);
                //if(i==length)
                //    printf("sequence ended (max length reached) %06x\n",pos);
                break;
            }
            else
                print_cmd(printstr);
        }
    }

    return i;
}

void define_songtable(char *name,uint16_t addr,uint8_t flag1,uint8_t flag2)
{
    name = set_label(baseaddr+addr,name);
    printf("%s located at %06x\n",name,baseaddr+addr);

    *(source_flag+baseaddr+addr) |= flag1|DATA_SEPARATOR;
    *(source_flag+read_pos(source+baseaddr+addr)) |= flag2;
}

void define_table(char *name,uint16_t addr,uint8_t flag1,uint8_t flag2)
{
    name = set_label(baseaddr+addr,name);
    printf("%s located at %06x\n",name,baseaddr+addr);
    *(source_flag+baseaddr+addr) |= flag1|DATA_SEPARATOR;
    *(source_flag+baseaddr+(read_word(source+baseaddr+addr))) |= flag2;
}

void define_dataonly(char *name,uint16_t addr,uint8_t flag1)
{
    name = set_label(baseaddr+addr,name);
    printf("%s located at %06x\n",name,baseaddr+addr);
    *(source_flag+baseaddr+addr) |= flag1|DATA_SEPARATOR;
}

int read_wavetable(uint32_t addr)
{
    uint16_t flags=0,bank=0;
    uint32_t addr2;
    int count;
    int res=0;
    int id=0;
    char temp[16];

    while(!res)
    {
        addr2=read_word(source+addr)+baseaddr;
        source_flag[addr2] |= DATA_SEPARATOR;

        if(!(source_flag[addr+2] & DATA_SEPARATOR))
            source_flag[read_word(source+addr+2)+baseaddr] |= DATA_SEPARATOR;

        sprintf(temp,"wave%03d",id);
        set_label(addr2,temp);

        if(!(source_flag[addr2] & DATA_DEFINED))
        {
            // tektagt : label change between linked samples.
            if(!(flags&0x20))
            {
                print_cmd("WORD");
                print_arg(0,ARG_HEX_WORD,read_word(source+addr2));
                // todo: print base samplerate.
                set_string(addr2,s_humandata);
                define_data(addr2,2,DATA_WAVE);
                addr2+=2;
            }
            do
            {
                bank = read_word(source+addr2);
                flags = read_word(source+addr2+2);

                count=4;

                if((flags&0x32) == 2)
                    count++;

                if(bank&0x8000) // jump to position
                    count=2;

                //printf("flags = %04x, %04x, %d\n",flags,flags&0x22,count);

                count = read_data(addr2,8,0,count);

                define_data(addr2,count*2,DATA_WAVE);

                addr2 += count*2;

                if(bank&0x8000) // jump to position
                    break;
                if(source_flag[addr2] & DATA_SEPARATOR)
                    break;

            }
            while(flags&0x20);

        }

        define_data(addr,2,DATA_DEFINED|DATA_WAVETABLE);
        addr+=2;

        if(source_flag[addr] & DATA_SEPARATOR)
            res=1;

        id++;
    }
    return id;
}

/*
   Envelope end sequence:
    ff ff
   Pan envelope end sequence
    80, 81, 82
   Pitch envelope end sequence
    ff (ignore first 2 bytes)
*/
int read_envtable(uint32_t addr, char* prefix, uint8_t tableflag, uint8_t dataflag)
{
    uint16_t flags;
    uint32_t addr2;
    uint32_t addr3;
    uint8_t* tempptr;
    int count;
    int res=0;
    int id=0;
    char temp[16];

    // scan once to set data separators at all entries (makes parsing easier)
    addr2=addr;
    while(1)
    {
        //printf("Putting Separator at %06x\n",read_word(source+addr2)+baseaddr);
        addr3 = read_word(source+addr2)+baseaddr;
        // this is often seen at the end of pitch env tables...
        if(dataflag == DATA_PITCHENV && addr3-baseaddr == 0x007f)
        {
            source_flag[addr2] |= DATA_SEPARATOR;
            break;
        }
        // ehrgeiz
        if(dataflag == DATA_PITCHENV && addr3-baseaddr == 0x3c3c && mcu_type == MCU_S12)
        {
            source_flag[addr2] |= DATA_SEPARATOR;
            break;
        }
        // ncv2
        if(dataflag == DATA_PITCHENV && addr3-baseaddr == 0xff1e && mcu_type == MCU_ND)
        {
            source_flag[addr2] |= DATA_SEPARATOR;
            break;
        }
        // extra bank for pitch envelopes
        if(dataflag == DATA_PITCHENV && startaddr == 0x8000 && addr3-baseaddr < 0x8000)
        {
            addr3 += 0x10000;
        }

        source_flag[addr3] |= DATA_SEPARATOR;
        addr2 += 2;
        if(source_flag[addr2] & DATA_SEPARATOR)
            break;
    }

    while(!res)
    {
        addr2=read_word(source+addr)+baseaddr;
        //printf("id=%03x addr=%04x\n",id,addr2);

        // extra bank for pitch envelopes
        //if(dataflag == DATA_PITCHENV && startaddr == 0x8000 && addr2-baseaddr < 0x8000)
        //{
        //    addr2 += 0x10000;
        //}
        sprintf(temp,"%s%03d",prefix,id);
        set_label(addr2,temp);

        count=128;
        switch(dataflag)
        {
        case DATA_ENV:
            // we're searching for a "word"...
            tempptr = source+addr2;
            while(1)
            {
                tempptr = memchr(tempptr,0xff,count);
                if(!tempptr || *(tempptr+1) == 0xff)
                    break;
                tempptr+=2;
            }
            if(tempptr)
                count = tempptr+2-source-addr2;
			count = read_data(addr2,8,1,count);
            break;
        case DATA_PITCHENV:
            // this code is also shit
            tempptr = memchr(source+addr2+2,0xff,count);
            if(tempptr)
                count = tempptr-source-addr2;
            tempptr = memchr(source+addr2+2,0xfe,count);
            if(tempptr)
                count = tempptr-source-addr2;
            tempptr = memchr(source+addr2+2,0xfd,count);
            if(tempptr)
                count = tempptr-source-addr2;
            count++;
			count = read_data(addr2,8,2,count);
            break;
		default:
			count = read_data(addr2,8,1,count);
        }
        //printf("Max length = %d\n",count);
        //count = read_data(addr2,8,1,count);

        define_data(addr2,count,DATA_DEFINED|dataflag);
        define_data(addr,2,DATA_DEFINED|tableflag);
        addr+=2;

        if(source_flag[addr] & DATA_SEPARATOR)
            res=1;
        if(source_flag[addr+1] & DATA_SEPARATOR)
            res=1;
        id++;
    }
    return id;
}

/*
 Reads LFO and macro tables
*/
int read_lfotable(uint32_t addr, char* prefix, uint8_t tableflag, int entrysize)
{
    if(entrysize == 0)
        return 0;
    uint16_t flags;
    uint32_t addr2;
    uint8_t* tempptr;
    int count;
    int res=0;
    int id=0;
    char temp[16];

    while(!res)
    {
        // starswep doesn't even have any macros.
        // dare to do DATA_DEFINED?....
        if(source_flag[addr] & DATA_DEFINED)
            return id;

        sprintf(temp,"%s%03d",prefix,id);

        set_label(addr,temp);

        count = read_data(addr,8,1,entrysize);

        define_data(addr,count,DATA_DEFINED|tableflag);
        addr+=count;

        if(source_flag[addr] & DATA_SEPARATOR)
            res=1;
        // LFOs can be at the end of a bank
        if(source[addr] == 0xff && source[addr+1] == 0xff)
            res=1;

        // simple validity check for macro maps, they're always sequential.
        // also means ridgerac/ridgera2/raveracw fail, but their macros aren't valid anyway.
        if(tableflag == DATA_MACROMAP && (source[addr+2] < source[addr] || source[addr+4] < source[addr+2]))
            res=1;

        id++;
    }
    return id;
}

int read_songtable(uint32_t addr, char* prefix, uint8_t tableflag)
{
    uint16_t flags;
    uint32_t addr2;
    int res=0;
    int id=0;
    char temp[16];

    while(!res)
    {
        //fprintf(stderr,"Parse song id %03x at %08x (%06x) (%02x) \n",id,read_pos(source+addr),addr, source_flag[addr]);

        memset(label_type_cnt,0,sizeof(label_type_cnt));

        addr2=read_pos(source+addr);

        if(addr2+posoffset == 0)
        {
            print_cmd("ADDR");
            print_arg(0,ARG_LONG,0);
            humandata_cnt += sprintf(s_humandata+humandata_cnt," ;       %03x (invalid!)",id);
            goto skip;  // sorry...
        }
        songpos=addr2;

        *(source_flag+songpos) |= DATA_SEPARATOR;

        s_tempo=0x50;
        s_speed=0x1e;

        sprintf(temp,"%s%03x_start",prefix,id);
        set_label(addr2,temp);

        sprintf(temp,"%s%03x",prefix,id);
        label_prefix = temp;

        songmsg = NULL;

        int i;
        for(i=0;i<8;i++)
            chtranspose[i]=0;

        //memset(source_flag,0,0x80000);

        stackpos=0;
        endflag=0;
        parsedbytes=0;
        while(!endflag)
        {
            //printf("%08x ",songpos);
            humandata_cnt=0;
            read_cmd();
            //printf("\n%08x %s \n",parsed_songpos,s_humandata);
            if(parsed_songpos != -1)
                set_string(parsed_songpos,s_humandata);
        }


        print_cmd("SONG");
        print_arg(0,ARG_ADDRESS,addr2);
        humandata_cnt += sprintf(s_humandata+humandata_cnt," ; %03x",id);
        if(parsedbytes)
            humandata_cnt += sprintf(s_humandata+humandata_cnt," (%5d bytes)",parsedbytes);
        if(songmsg)
            humandata_cnt += sprintf(s_humandata+humandata_cnt," \"%s\"",songmsg);


skip:
        set_string(addr,s_humandata);

        define_data(addr,2,DATA_DEFINED|tableflag);
        addr+=2;

        //if(id==0x10)
        //    res=1;

        if(source_flag[addr+1] & DATA_SEPARATOR)
            res=1;
        if(source_flag[addr+2] & DATA_SEPARATOR)
            res=1;
        if(source_flag[addr] & DATA_SEPARATOR)
            res=1;
        id++;

        //sleep(1);
    }
    return id;
}

void find_padding(int padsize)
{
    int pos = sourcefile_size-1;
    int pos2;
    uint8_t pad_byte;
    while(pos>0)
    {
        if(mcu_type == MCU_SS22 && pos==0xffff)
            pos = 0xbfff;

        pad_byte = *(source+pos);
        pos2=pos;
        while(*(source+pos2) == pad_byte && *(source_flag+pos2) == 0x00)
        {
            pos2--;
        }

        if(pos2 < pos)
        {
            define_data(pos2+1,pos-pos2,DATA_PAD);

            print_cmd("ORG");
            print_arg(0,ARG_LONG,pos+1);
            set_string(pos2+1,s_humandata);

            fprintf(stderr,"padding at %06x - %06x\n",pos2+1,pos);
        }
        else
            printf("no padding %06x\n",pos);

        do
        {
            //pos -= 0x10000;
            pos -= padsize;
        }
        while(pos>0 && *(source_flag+pos) & DATA_DEFINED);

        printf("pos = %06x\n",pos);
    }

}


// memchr replacement, we need to check for both 0x00 and 0x40 (data separator)
void *find_empty(const void *s, size_t n)
{
    uint8_t *p = (uint8_t*)s;
    while( n-- )
        if( *p != 0x00 && *p != 0x40 )
            p++;
        else
            return p;
    return 0;
}

void find_songchunk()
{
    char temp2[24];
    int pos = 1;
    int pos2 = 0;
    int nopcount;
    uint8_t flag;
    uint8_t *temp;
    while(pos<sourcefile_size)
    {
        temp = find_empty(source_flag+pos,sourcefile_size-pos);
        if(temp)
            pos = temp-source_flag;
        else
            break;

        pos2 = pos;

        while( (*(source_flag + pos2)&0xbf) == 0)
        {
            pos2++;
        }

        if((*(source_flag + pos -1)&0x0f) == DATA_SONG && (*(source+pos) != 0xff || *(source+pos+1) != 0xff || *(source+pos+2) != 0xff))
        {
            memset(label_type_cnt,0,sizeof(label_type_cnt));

            songpos=pos;
            chflag=0;

            s_tempo=0x50;
            s_speed=0x1e;

            //printf("parse chunk %06x\n",pos);
            sprintf(temp2,"cnk_%06x",pos);
            label_prefix = temp2;

            songmsg = NULL;

            int i;
            for(i=0;i<8;i++)
                chtranspose[i]=0;

            //memset(source_flag,0,0x80000);
            stackpos=0;
            endflag=0;
            parsedbytes=0;
            nopcount=0;
            while(!endflag)
            {
                //printf("%08x ",songpos);
                humandata_cnt=0;
                read_cmd();

                if(source[songpos] == 0xff)
                    nopcount++;
                else
                    nopcount=0;
                if(nopcount == 8)
                    endflag=1;

                //printf("\n%08x %s \n",parsed_songpos,s_humandata);
                if(parsed_songpos != -1)
                    set_string(parsed_songpos,s_humandata);
            }

            // also create a label if data is big enough...
            if(parsedbytes > 15 || chflag)
            {
                if(chflag)
                    printf("Unreferenced chunk located at %06x. (Size: %5d bytes)!\n",pos,parsedbytes);
                else
                {
                    //printf("Unreferenced chunk located at %06x. (Size: %5d bytes)\n",pos,parsedbytes);
                }
                sprintf(temp2,"cnk_%06x",pos);
                set_label(pos,temp2);
            }

        }
        else
        {
            while( (*(source_flag + pos2)&0xbf) == 0)
            {
                pos2++;
            }
            pos = pos2;
        }
    }
}

void find_unknown()
{
    int pos = 0;
    int pos2 = 0;
    uint8_t flag;
    uint8_t *temp;
    while(pos<sourcefile_size)
    {
        temp = find_empty(source_flag+pos,sourcefile_size-pos);
        if(temp)
            pos = temp-source_flag;
        else
            break;

        flag = 0;
        if(pos == drv_start)
            flag = DATA_DRIVER;

        pos2 = pos;

        while( (*(source_flag + pos2)&0xbf) == 0)
        {
            pos2++;
        }

        if(flag == DATA_DRIVER)
            printf("Sound driver chunk located at %06x - %06x. (Size: %d bytes)\n",pos,pos2-1,pos2-pos);
        else if(pos2-pos > 15)
            printf("Unknown data chunk located at %06x - %06x. (Size: %d bytes)\n",pos,pos2-1,pos2-pos);

        if(flag == DATA_DRIVER)
        {
            define_data(pos,pos2-pos,flag);
            print_cmd("INCBIN");
            sprintf(s_humandata+humandata_cnt,"\"driver.bin\" ; size: %d bytes",pos2-pos);
            flag = DATA_DRIVER;
            set_string(pos,s_humandata);
        }
        else
        {
            define_data(pos,pos2-pos,0);
            read_data(pos,8,1,pos2-pos);
        }

        pos = pos2;

    }

}

void print_string(int i,FILE* out)
{
	int j,k;
	if(source_flag[i] & LABEL_DEFINED)
	{
		if(options & PRINT_ADDR)
			fprintf(out,"%06x\t",i+posoffset);
		if(options & PRINT_HEX)
		{
			for(j=0;j<7;j++)
				fprintf(out,"   ");
		}
		fprintf(out,"%s:\n",source_labels[i]);
		
	}
	if(source_flag[i] & DATA_PARSED)
	{
		char* str = source_strings[i];

		while(1)
		{
			if(options & PRINT_ADDR)
				fprintf(out,"%06x\t",i+posoffset);
			
			if(options & PRINT_HEX)
			{
				k=i;
				for(j=0;j<7;j++)
				{
					if(k<0x80000)
					{
						fprintf(out,"%02x ",source[k]);
						k++;
						if(source_flag[k] & DATA_PARSED)
							k = 0x80000;
					}
					else
						fprintf(out,"   ");
				}
			}
			
			
			fprintf(out,"\t%s\n",str);
			str += strlen(str)+1;
			
			if(*str == 0)
				break;
		}
	}
}


void decompile_all(char *out_asm,char *out_label,char *out_flag)
{
    int i;
    uint32_t driver_crc = crc32(source+drv_start,drv_end-drv_start);

    printf("Detected Driver Type: %s\nAddress Base : %06x\nSound header location : %06x\n\n", MCUNames[mcu_type], posoffset, startaddr);

    printf("Driver CRC32 : 0x%08x\n", driver_crc);

    //GetMCUVersion();

    define_data(startaddr,0x0e,DATA_HEADER);

    set_label(startaddr,"q_header");

    define_songtable("tab_song",read_word(source+startaddr+0x00),DATA_SONGTABLE,DATA_SEPARATOR);
    define_dataonly("tab_lfo",read_word(source+startaddr+0x04),DATA_LFO);
    define_table("tab_pitch",read_word(source+startaddr+0x06),DATA_PITCHENVTABLE,DATA_SEPARATOR);
    define_dataonly("tab_patch",read_word(source+startaddr+0x08),DATA_WAVE);

    pitchcount =read_envtable(baseaddr+read_word(source+startaddr+0x06),"pitch",DATA_PITCHENVTABLE,DATA_PITCHENV);
    songcount = read_songtable(baseaddr+read_word(source+startaddr+0x00),"song",DATA_SONGTABLE);
    wavecount =read_lfotable(baseaddr+read_word(source+startaddr+0x08),"patch",DATA_WAVE,32);
    lfocount =read_lfotable(baseaddr+read_word(source+startaddr+0x04),"lfo",DATA_LFO,5);


    //define_table("tab_wave",read_word(source+startaddr+0x02),DATA_WAVETABLE,DATA_SEPARATOR);
    //define_table("tab_pitch",read_word(source+startaddr+0x04),DATA_PITCHENVTABLE,DATA_SEPARATOR);
    //define_table("tab_env",read_word(source+startaddr+0x06),DATA_ENVTABLE,DATA_SEPARATOR);
    //define_table("tab_pan",read_word(source+startaddr+0x08),DATA_PANENVTABLE,DATA_SEPARATOR);
    //define_dataonly("tab_lfo",read_word(source+startaddr+0x0A),DATA_LFO);
    //define_dataonly("tab_macro",read_word(source+startaddr+0x0C),DATA_MACROMAP);

    //wavecount = read_wavetable(baseaddr+read_word(source+startaddr+0x02));
    //pitchcount =read_envtable(baseaddr+read_word(source+startaddr+0x04),"pitch",DATA_PITCHENVTABLE,DATA_PITCHENV);
    //envcount =  read_envtable(baseaddr+read_word(source+startaddr+0x06),"env",DATA_ENVTABLE,DATA_ENV);
    //pancount =  read_envtable(baseaddr+read_word(source+startaddr+0x08),"pan",DATA_PANENVTABLE,DATA_PANENV);
    //lfocount =  read_lfotable(baseaddr+read_word(source+startaddr+0x0a),"lfo",DATA_LFO,8);
    //songcount = read_songtable(baseaddr+read_word(source+startaddr+0x00),"song",DATA_SONGTABLE);
    // Macros have to be parsed last.
    //macrocount =read_lfotable(baseaddr+read_word(source+startaddr+0x0c),"macro",DATA_MACROMAP,16);

    //Temporary table reading routines, remove as proper parsers are added.
    //read_table(baseaddr+read_word(source+startaddr+0x00),1,1); // Song data
    //read_table(baseaddr+read_word(source+startaddr+0x06),8,0); // Wave information
    read_table(baseaddr+read_word(source+startaddr+0x06),8,0); // Pitch envelope
    //read_table(baseaddr+read_word(source+startaddr+0x06),8,0); // Volume envelope
    //read_table(baseaddr+read_word(source+startaddr+0x08),8,0); // Pan envelope

    read_table(startaddr,7,0);

    find_padding(0x10000); // sound banks
    if(!ignore_unreferenced)
        find_songchunk();

    // this will be put behind a switch if needed.
	if(options & AGGRESSIVE_PADDING)
		find_padding(0x1000); // propcycl

    find_unknown();

    int datacount[16];
    memset(datacount,0,16*sizeof(int));
    for(i=0;i<sourcefile_size;i++)
    {
        datacount[source_flag[i]&0x0f]++;
    }

    printf("Writing %s\n",out_flag);
    FILE *destfile;
    destfile = fopen(out_flag,"wb");
    if(!destfile)
    {
        printf("Could not write\n");
        exit(EXIT_FAILURE);
    }
    for(i=0;i<sourcefile_size;i++)
    {
        putc(*(source_flag+i),destfile);
    }
    fclose(destfile);

    printf("Writing %s\n",out_asm);
    destfile = fopen(out_asm,"w");
    if(!destfile)
    {
        printf("Could not write\n");
        exit(EXIT_FAILURE);
    }

    fprintf(destfile,"; This file was generated by dsseq (build date: %s)\n;\n",__DATE__);
    fprintf(destfile,"; File Statistics: \n");
    //                    12345678901234567890123
    fprintf(destfile,";   Song count:            %4d \n",songcount);
    fprintf(destfile,";   Wave count:            %4d \n",wavecount);
    fprintf(destfile,";   Pitch envelope count:  %4d \n",pitchcount);
    fprintf(destfile,";   Volume envelope count: %4d \n",envcount);
    fprintf(destfile,";   Pan envelope count:    %4d \n",pancount);
    fprintf(destfile,";   LFO preset count:      %4d \n",lfocount);
    fprintf(destfile,";   Macro map count:       %4d \n",macrocount);
    fprintf(destfile,"; File Usage Statistics: \n");
    for(i=0;i<16;i++)
    {
        fprintf(destfile,";   %-22s%5x (%6d) (%.2f%%) \n", DataNames[i], datacount[i], datacount[i], (double)100*datacount[i]/sourcefile_size);
    }

    for(i=0;i<sourcefile_size;i++)
    {
        print_string(i,destfile);
    }
    fclose(destfile);

    printf("Writing %s\n",out_label);
    destfile = fopen(out_label,"w");
    if(!destfile)
    {
        printf("Could not write\n");
        exit(EXIT_FAILURE);
    }
    for(i=0;i<sourcefile_size;i++)
    {
        if(source_flag[i] & LABEL_DEFINED)
        {
            fprintf(destfile,"%06x\t%s:\n",i+posoffset,source_labels[i]);
        }
    }
    fclose(destfile);
}

void decompile_song(char *out_asm,char *out_label,char *out_flag,int addr2)
{
    char temp[16];
    memset(label_type_cnt,0,sizeof(label_type_cnt));

    songpos=addr2;

    s_tempo=0x50;
    s_speed=0x1e;

    sprintf(temp,"song_start");
    set_label(addr2,temp);

    sprintf(temp,"song");
    label_prefix = temp;

    songmsg = NULL;

    int i;
    for(i=0;i<8;i++)
        chtranspose[i]=0;

    //memset(source_flag,0,0x80000);

    stackpos=0;
    endflag=0;
    parsedbytes=0;
    while(!endflag)
    {
        //printf("%08x ",songpos);
        humandata_cnt=0;
        read_cmd();
        //printf("\n%08x %s \n",parsed_songpos,s_humandata);
		if(parsed_songpos != -1)
            set_string(parsed_songpos,s_humandata);
    }



    printf("Writing %s\n",out_flag);
    FILE *destfile;
    destfile = fopen(out_flag,"wb");
    if(!destfile)
    {
        printf("Could not write\n");
        exit(EXIT_FAILURE);
    }
    for(i=0;i<sourcefile_size;i++)
    {
        putc(*(source_flag+i),destfile);
    }
    fclose(destfile);

    printf("Writing %s\n",out_asm);
    destfile = fopen(out_asm,"w");
    if(!destfile)
    {
        printf("Could not write\n");
        exit(EXIT_FAILURE);
    }

    fprintf(destfile,"; This file was generated by qseq (build date: %s)\n;\n",__DATE__);

    for(i=0;i<sourcefile_size;i++)
    {
        print_string(i,destfile);
    }
    fclose(destfile);

    printf("Writing %s\n",out_label);
    destfile = fopen(out_label,"w");
    if(!destfile)
    {
        printf("Could not write\n");
        exit(EXIT_FAILURE);
    }
    for(i=0;i<sourcefile_size;i++)
    {
        if(source_flag[i] & LABEL_DEFINED)
        {
            fprintf(destfile,"%06x\t%s:\n",i+posoffset,source_labels[i]);
        }
    }
    fclose(destfile);
}

void open_file(char *filename)
{
    FILE* sourcefile;
    sourcefile = fopen(filename,"rb");

    if(!sourcefile)
    {
        printf("Could not open %s\n",filename);
        perror("Error");
        exit(EXIT_FAILURE);
    }
    fseek(sourcefile,0,SEEK_END);
    sourcefile_size = ftell(sourcefile);
    rewind(sourcefile);
    source = (uint8_t*)malloc(sourcefile_size);
    source_flag = (uint8_t*)malloc(sourcefile_size);
    source_labels = (char**)malloc(sourcefile_size*sizeof(char**));
    source_strings = (char**)malloc(sourcefile_size*sizeof(char**));

    int res;
    res = fread(source,1,sourcefile_size,sourcefile);
    if(res != sourcefile_size)
    {
        printf("Reading error\n");
        exit(EXIT_FAILURE);
    }

    memset(source_flag,0,sourcefile_size);
}


int main(int argc, char* argv [])
{
    ignore_unreferenced=0;
    char filename[FILENAME_MAX];
    char flagname[FILENAME_MAX];
    char labelname[FILENAME_MAX];
    char outname[FILENAME_MAX];

    int standard_args=0;
    char* startaddr_use = NULL;
    char* s = NULL;

    char* source_name = NULL;
    char* filename_use = NULL;
    char* flagname_use = NULL;
    char* labelname_use = NULL;
    char* outname_use = NULL;

    char* tempstr;

	options=0;
    readmode=0;
    int songno=0;

    startaddr=0;
    posoffset=0;
	posoffset2=0;


    /*
    if(argc<2)
        return;
    if(argc>2)
    {
        readmode=1;
        songno = (int)strtoul(argv[2],NULL,0);
    }

    open_file(argv[1]);
    */

    int a, i, startarg=1;

    for(a=1;a<argc;a++)
    {
        if((!strcmp(argv[a],"-p") || !strcmp(argv[a],"--pointer-offset")) && a<argc)
        {
            startaddr = (uint32_t)strtoul(argv[a+1],NULL,0);
            a++;
            startarg+=2;
        }
        else if((!strcmp(argv[a],"-b") || !strcmp(argv[a],"--base-offset")) && a<argc)
        {
            posoffset2 = (uint32_t)strtoul(argv[a+1],NULL,0);
            a++;
            startarg+=2;
        }
        else if((!strcmp(argv[a],"-s") || !strcmp(argv[a],"--song")) && a<argc)
        {
            songno = (int)strtoul(argv[a+1],NULL,0);
			if(songno < 0x10000)
				posoffset2=0x4000;
            a++;
            startarg+=2;
        }
        else if(!strcmp(argv[a],"-f") || !strcmp(argv[a],"--fm"))
        {
			options |= FM_TRANSPOSE;
            //posoffset2=0x4000;
            startarg++;
        }
        else if(!strcmp(argv[a],"-n") || !strcmp(argv[a],"--na"))
        {
			options |= DRIVER_NA;
            //posoffset2=0x4000;
            startarg++;
        }
        else if(!strcmp(argv[a],"-i") || !strcmp(argv[a],"--s1"))
        {
			options |= DRIVER_S1;
            //posoffset2=0x4000;
            startarg++;
        }
        else if(!strcmp(argv[a],"-j") || !strcmp(argv[a],"--s1old"))
        {
			options |= DRIVER_S1 | DRIVER_S1OLD;
            //posoffset2=0x4000;
            startarg++;
        }
        else if(!strcmp(argv[a],"-u") || !strcmp(argv[a],"--ignore-unreferenced"))
        {
            ignore_unreferenced=1;
            startarg++;
        }
        else if(!strcmp(argv[a],"-h") || !strcmp(argv[a],"--print-hex"))
        {
            options |= PRINT_HEX;
            startarg++;
        }
        else if(!strcmp(argv[a],"-a") || !strcmp(argv[a],"--print-addresses"))
        {
            options |= PRINT_ADDR;
            startarg++;
        }
        else if(!strcmp(argv[a],"-e") || !strcmp(argv[a],"--expand-rests"))
        {
            options |= EXPAND_RESTS;
            startarg++;
        }
        else if(!strcmp(argv[a],"-ap") || !strcmp(argv[a],"--aggressive-padding"))
        {
            options |= AGGRESSIVE_PADDING;
            startarg++;
        }
        else
        {
            if(standard_args == 0)
                source_name = argv[a];
            else if(standard_args == 1)
                filename_use = argv[a];
            else if(standard_args == 2)
                labelname_use = argv[a];
            else if(standard_args == 3)
                flagname_use = argv[a];
            else
                break;
            standard_args++;
        }
    }
	
	if(options & DRIVER_NA)
		posoffset2=0;

    if(standard_args < 1)
    {
        printf("usage: %s [options] filename.bin [output.lst] [labels.txt] [usagemask.bin] \n",argv[0]);
        return -1;
    }
    if(standard_args < 2)
    {
        strcpy(filename,source_name);
        tempstr = strrchr(filename,'.');
        sprintf(tempstr,".txt");
        filename_use=filename;

    }
    if(standard_args < 3)
    {
        /*
        strcpy(flagname,source_name);
        tempstr = strrchr(flagname,'.');
        sprintf(tempstr,".usagemask.bin");
        */
        sprintf(labelname,"labels.txt");
        labelname_use=labelname;
    }
    if(standard_args < 4)
    {
        /*
        strcpy(flagname,source_name);
        tempstr = strrchr(flagname,'.');
        sprintf(tempstr,".usagemask.bin");
        */
        sprintf(flagname,"usagemask.bin");
        flagname_use=flagname;
    }

    open_file(source_name);

    GetSongOffset();
    /*
    if(argc>3)
        startaddr = (int)strtoul(argv[3],NULL,0);
    if(argc>4)
        posoffset = (int)strtoul(argv[4],NULL,0);
    */
    baseaddr = startaddr&0xff0000;

    if(readmode)
    {
        uint8_t* songtab = source + ((source[startaddr]) | (source[startaddr+1]&0x7f)<<8) + startaddr;

        //printf("Detected Driver Type: %s\nAddress Base : %06x\nSound header location : %06x\n", MCUNames[mcu_type], posoffset, startaddr);

        printf("Song table located at %p\n", songtab-source);

        parsedbytes=0;

        uint8_t* data2;
        int addr;

        data2 = songtab + (songno*3);

        addr = read_pos(data2);

        printf("%02x : %06x\n",songno,addr);

        songpos = addr;

        read_song();
    }
    else
    {
        if(songno)
        {
            decompile_song(filename_use,labelname_use,flagname_use,songno);
        }
        else
            decompile_all(filename_use,labelname_use,flagname_use);
		//fprintf(stderr,"Use song mode (--song <addr>)\n");

    }

    free(source);
    free(source_flag);
}


/*
 format for header data:

    WORD  tab_song ; Song count: nnn;


   pointer_table
   tab_song
   song_xx
   tab_wave
   wave_xx
   tab_pitchenv
   pitchenv_xx
   tab_env
   env_xx
   tab_panenv
   panenv_xx
   tab_lfo
   tab_macro

   ORG $10000
   ORG $20000
   etc...


    song00
    pitch00
    env00
    pan00



tab_song
    SONG  song_00; <song message found>
    SONG  song_01; etc...
tab_pitchenv
    WORD  pitchenv_00,pitchenv_01,pitchenv_02,pitchenv_03,pitchenv_04,pitchenv_05,pitchenv_06,pitchenv_07
tab_env
    WORD  env_00,env_01,env_02,env_03,env_04,env_05,env_06,env_07
tab_panenv
    WORD  panenv_00,panenv_01,panenv_02,panenv_03,panenv_04,panenv_05,panenv_06,panenv_07

...........

*/
