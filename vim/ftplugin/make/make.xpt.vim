XPTemplate priority=lang-1

let s:f = g:XPTfuncs()

XPTvar $TRUE          1
XPTvar $FALSE         0
XPTvar $NULL          NULL
XPTvar $UNDEFINED     NULL

XPTvar $VOID_LINE     # void
XPTvar $CURSOR_PH     # cursor

XPTvar $CS            #

XPTinclude
      \ _common/common
      \ _comment/singleSign


" ========================= Function and Variables =============================


" ================================= Snippets ===================================

XPT fullmake " $(VERBOSE).SILENT: ...
$(VERBOSE).SILENT:

PROGNAME = `progname^

CC = gcc
CC += -c
CPP = g++
CPP += -c
ASM = nasm
ASM += -f elf -d ELF_TYPE
LD = g++

OBJFILES = $(patsubst %.c,%.o,$(wildcard *.c))
OBJFILES += $(patsubst %.s,%.o,$(wildcard *.s))
OBJFILES += $(patsubst %.cpp,%.o,$(wildcard *.cpp))

all: $(PROGNAME)

clean:
	@echo "Cleaning object files"
	@echo "    rm -f     *.o"
	rm -f *.o
	@echo "Cleaning backups"
	@echo "    rm -f     *~"
	rm -f *~
	@echo "Removing programme"
	@echo "    rm -f     "$(PROGNAME)
	rm -f $(PROGNAME)

%.o: %.s
	@echo "Assambling "$@
	@echo "    ASM       "$<
	$(ASM) $<

%.o: %.c
	@echo "Compiling "$@
	@echo "    CC        "$<
	$(CC) $<

%.o: %.cpp
	@echo "Compiling "$@
	@echo "    CPP       "$<
	$(CPP) $<

$(PROGNAME): $(OBJFILES)
	@echo "Linking "$@
	@echo "    LD        -o "$(PROGNAME)"        "$(OBJFILES)
	$(LD) -o $(PROGNAME) $(OBJFILES)

strip: $(PROGNAME)
	@echo "Stripping "$(PROGNAME)
	echo -n "Size of "$(PROGNAME)" before strip is "
	ls -sh $(PROGNAME) | cut -d' ' -f1
	@echo "    strip     "$(PROGNAME)
	strip $(PROGNAME)
	echo -n "Size of "$(PROGNAME)" after strip is "
	ls -sh $(PROGNAME) | cut -d' ' -f1

nothing:
	@echo "Nothing to do; quitting  :("
	@echo "HINT: Try make all"
..XPT
