-include ../../../../../branch_src_sharedMemory_integration/Tools/MConfig/.config
include ../../../../../include/MakeConfig
rm=/bin/rm -f
CC= $(MYCC)
LINK= -=LINK=-
DEFS=  
AR= $(MYAR) cq
RANLIB= $(MYRANLIB)

INCLUDES= -I. -I../../../../Include -I../../../../Platform_Lib/HTTPC/src -I../../../../../../common/IPC/include -I../../../../../../common/IPC/generate/include/system

DEFINES+= $(INCLUDES) $(DEFS) -DSYS_UNIX=1 -DHAVE_STRING_H -DRDDEBUG -DINPUT_USE_IO_PLUGIN 
CFLAGS= $(DEFINES) $(COMPILE_OPT)


LIBNAME= ../../../../../lib/libHttpIOPlugin.a

ifneq ($(filter APCFG_MODULE_IMS,$(subst |, ,$(APCFG_FLAGS))), )
SRCS = HttpIOPlugin.c TranscodeIOPlugin.c io_helper.c
OBJS = HttpIOPlugin.o TranscodeIOPlugin.o io_helper.o
else
    ifneq ($(filter APCFG_APP_HTTPCLIENT,$(subst |, ,$(APCFG_FLAGS))), )
    SRCS = HttpIOPlugin.c TranscodeIOPlugin.c io_helper.c
    OBJS = HttpIOPlugin.o TranscodeIOPlugin.o io_helper.o
    else
SRCS = HttpIOPlugin_empty.c TranscodeIOPlugin.c io_helper.c
OBJS = HttpIOPlugin_empty.o TranscodeIOPlugin.o io_helper.o
    endif
endif

.c.o:
	$(SHOW_COMMAND)$(rm) -f $@
	$(SHOW_COMMAND)echo -=--=--=- [$*.c] -=--=--=--=--=--=--=--=--=-
	$(SHOW_COMMAND)$(CC) $(INCLUDES) $(CFLAGS) $(DEBUGFLAG)  $(WARNING) -O -c  $*.c

.cpp.o:
	$(SHOW_COMMAND)$(rm) -f $@
	$(SHOW_COMMAND)echo -=--=--=- [$*.cpp] -=--=--=--=--=--=--=--=--=-
	$(SHOW_COMMAND)$(CC) $(CFLAGS) $(DEBUGFLAG) -c $*.cpp

all: $(LIBNAME)

$(LIBNAME) : $(OBJS)
	$(SHOW_COMMAND)$(rm) $@
	$(SHOW_COMMAND)$(AR) $@ $(OBJS)
	$(SHOW_COMMAND)$(RANLIB) $@

clean:
	$(SHOW_COMMAND)$(rm) $(OBJS) $(LIBNAME) core *~
