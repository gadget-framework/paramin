################################################################
# Common for all architecture and compiler options
################################################################
GCCWARNINGS = -Wimplicit -Wreturn-type -Wswitch -Wcomment -Wformat \
              -Wparentheses -Wpointer-arith -Wcast-qual -Wconversion \
              -Wreorder -Wwrite-strings -Wsynth -Wchar-subscripts \
              -Wuninitialized -pedantic -W

PVMDIR = $(PVM_ROOT)
PVMLIBDIR = -L$(PVM_ROOT)/lib/$(PVM_ARCH)
PVMINCLUDE = $(PVM_ROOT)/include

# Pick the appropriate platform and libraries from the following switches
################################################################
# For options 2 and 4, 5 and 6, the Gadget input library needs to be compiled
# first - see the Makefile for Gadget to create libgadgetinput.a
# and the location of the gadget directory needs to be set here
GADGETDIR = ../gadget
################################################################
# 1. Linux, g++ compiler, no gadget library
#CXX = g++
#LIBDIRS = $(PVMLIBDIR)
#LIBRARIES = -lm -lnsl -lpvm3
#DEFINE_FLAGS = -D NDEBUG -O3
#CXXFLAGS = $(GCCWARNINGS) $(DEFINE_FLAGS) -I$(PVMINCLUDE)
################################################################
# 2. Linux, g++ compiler, with gadget library
CXX = g++
LIBDIRS = $(PVMLIBDIR) -L. -L$(GADGETDIR)
LIBRARIES = -lm -lnsl -lpvm3 -lgadgetinput
DEFINE_FLAGS = -D NDEBUG -D GADGET_NETWORK -O3
CXXFLAGS = $(GCCWARNINGS) $(DEFINE_FLAGS) -I$(PVMINCLUDE) -I$(GADGETDIR)
################################################################
# 3. Solaris, g++ compiler, no gadget library
#CXX = g++
#LIBDIRS = $(PVMLIBDIR)
#LIBRARIES = -lm -lpvm3 -lnsl -lsocket
#DEFINE_FLAGS = -D NDEBUG -O3
#CXXFLAGS = $(GCCWARNINGS) $(DEFINE_FLAGS) -I$(PVMINCLUDE)
################################################################
# 4. Solaris, g++ compiler, with gadget library
#CXX = g++
#LIBDIRS = $(PVMLIBDIR) -L. -L$(GADGETDIR)
#LIBRARIES = -lm -lnsl -lpvm3 -lsocket -lgadgetinput
#DEFINE_FLAGS = -D NDEBUG -D GADGET_NETWORK -O3
#CXXFLAGS = $(GCCWARNINGS) $(DEFINE_FLAGS) -I$(PVMINCLUDE) -I$(GADGETDIR)
################################################################
# 5. Linux, g++ compiler, with gadget library running CONDOR
#CXX = g++
#LIBDIRS = $(PVMLIBDIR) -L. -L$(GADGETDIR)
#LIBRARIES = -lm -lnsl -lpvm3 -lgadgetinput
##DEFINE_FLAGS = -D DEBUG -D GADGET_NETWORK -g -O
#DEFINE_FLAGS = -D CONDOR -D NDEBUG -D GADGET_NETWORK -O3
#CXXFLAGS = $(GCCWARNINGS) $(DEFINE_FLAGS) -I$(PVMINCLUDE) -I$(GADGETDIR)
###############################################################
# 6. Solaris, g++ compiler, with gadget library running CONDOR
#CXX = g++
#LIBDIRS = $(PVMLIBDIR) -L. -L$(GADGETDIR)
#LIBRARIES = -lm -lnsl -lpvm3 -lsocket -lgadgetinput
#DEFINE_FLAGS = -D CONDOR -D NDEBUG -D GADGET_NETWORK -O3
#CXXFLAGS = $(GCCWARNINGS) $(DEFINE_FLAGS) -I$(PVMINCLUDE) -I$(GADGETDIR)
###############################################################

OBJECTS =  paramin.o processmanager.o netdatacontrol.o netgradient.o \
	netcommunication.o linesearch.o netinterface.o netdatainterface.o \
	netcomminterface.o condition.o datascaler.o dataconverter.o \
	vector.o datastructure.o slavecommunication.o netdata.o pvmconstants.o \
	commandlineinfo.o optimizer.o paraminsearch.o paraminhooke.o \
	paraminsimann.o paraminbfgs.o armijo.o wolfe.o lineseeker.o

LDFLAGS = $(CXXFLAGS) $(LIBDIRS) $(LIBRARIES)

paramin	:	$(OBJECTS)
	$(CXX) -o paramin $(OBJECTS) $(LDFLAGS)

clean:
	rm -f $(OBJECTS)

# DO NOT DELETE THIS LINE -- make depend depends on it.
