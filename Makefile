DEL ?= rm
CCOPY ?= cp 
PYTHON = python3
BINDIR ?= /Volumes/projects/neo6502/neo6502-firmware/bin

INVADERSSRC = $(shell find . -name '*.bsc')
INVADERSBAS = storage/$(subst bsc,bas,$(INVADERSSRC))

invaders: $(INVADERSBAS) images/graphics.gfx
	$(CCOPY) images/graphics.gfx storage

run: invaders
	$(BINDIR)/neo $(BINDIR)/basic.bin@800 storage/invaders.bas@3900 exec

images/graphics.gfx: images/sprite_16.png images/sprite_32.png images/tile_16.png
	cd images && $(PYTHON) $(BINDIR)/makeimg.zip

storage/%.bas : %.bsc
	$(PYTHON) $(BINDIR)/makebasic.zip $< -o$@

clean:
	$(DEL) $(INVADERSBAS) images/graphics.gfx
