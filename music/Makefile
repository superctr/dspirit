#==============================================================================
#
#  Copyright © 2021 Ian Karlsson
#
#==============================================================================

# source include directory
INCDIR=./include
# binary include directory
INCBIN=./incbin
# sample include directory
WAVDIR=./samples

# assembler, linker
AS=./tools/ca65
LD=./tools/ld65

# tools
ROMTOOL=./tools/romtool

# options to pass to the linker
LDOPTIONS= -m music.map
# linker configuration file
CFGFILE=music.cfg
# output file
PRGROM=music.bin

# source file directory
SRC=./src

# object file directory
OBJ=./obj

OBJS = \
	$(OBJ)/_header.o \
	$(OBJ)/_song.o \
	$(OBJ)/_lfo.o \
	$(OBJ)/_pitenv.o \
	$(OBJ)/_patch.o \
	$(OBJ)/init.o \
	$(OBJ)/opening.o \
	$(OBJ)/departure.o \
	$(OBJ)/area1_md.o \
	$(OBJ)/area2.o \
	$(OBJ)/area3.o \
	$(OBJ)/area4.o \
	$(OBJ)/area5.o \
	$(OBJ)/area6.o \
	$(OBJ)/area7.o \
	$(OBJ)/area8.o \
	$(OBJ)/area91.o \
	$(OBJ)/area92.o \
	$(OBJ)/area93.o \
	$(OBJ)/boss1.o \
	$(OBJ)/boss2.o \
	$(OBJ)/boss3.o \
	$(OBJ)/boss4.o \
	$(OBJ)/lastboss.o \
	$(OBJ)/lastscene.o \
	$(OBJ)/continue.o \
	$(OBJ)/name1.o \
	$(OBJ)/name2.o \
	$(OBJ)/ending.o \
	$(OBJ)/lrcheck.o \
	$(OBJ)/midnight.o \
	$(OBJ)/omake.o \
	$(OBJ)/effect.o

build:	$(OBJS)
	$(LD) -C $(CFGFILE) $(LDOPTIONS) $(OBJS) -o $(PRGROM)

$(OBJ)/%.o:	$(SRC)/%.s
	mkdir -p $(@D)
	$(AS) -I $(INCDIR) --bin-include-dir $(INCBIN) -o $@ -l ./lst/$(<F).lst $<

clean:
	rm -f $(OBJ)/*.o $(OBJ)/*.s

cb: clean build

.PHONY: build clean cb
