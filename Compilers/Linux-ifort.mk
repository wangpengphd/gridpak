#
# Include file for Intel IFORT (version 8.x) compiler on Linux
# -----------------------------------------------------------------
#
# ARPACK_LIBDIR  ARPACK libary directory
# FC             Name of the fortran compiler to use
# FFLAGS         Flags to the fortran compiler
# CPP            Name of the C-preprocessor
# CPPFLAGS       Flags to the C-preprocessor
# CLEAN          Name of cleaning executable after C-preprocessing
# NETCDF_INCDIR  NetCDF include directory
# NETCDF_LIBDIR  NetCDF libary directory
# LD             Program to load the objects into an executable
# LDFLAGS        Flags to the loader
# RANLIB         Name of ranlib command
# MDEPFLAGS      Flags for sfmakedepend  (-s if you keep .f files)
#
# First the defaults
#
               FC := ifort
           FFLAGS :=
              CPP := /usr/bin/cpp
         CPPFLAGS := -P -traditional -DLINUX
            CLEAN := Bin/cpp_clean
               LD := ncargf90
#               LD := ifort
          LDFLAGS := 
               AR := ar
          ARFLAGS := r
	    MKDIR := mkdir -p
               RM := rm -f
           RANLIB := ranlib
             PERL := perl
	     TEST := test

        MDEPFLAGS := --cpp --fext=f90 --file=-

#
# Library locations, can be overridden by environment variables.
#

        NC_CONFIG ?= nc-config
    NETCDF_INCDIR ?= $(shell $(NC_CONFIG) --prefix)/include
             LIBS := $(shell $(NC_CONFIG) --flibs)

         CPPFLAGS += -I$(NETCDF_INCDIR)

ifdef ARPACK
    ARPACK_LIBDIR ?= /opt/intelsoft/ARPACK
             LIBS += -L$(ARPACK_LIBDIR) -larpack_LINUX
endif

ifdef MPI
         CPPFLAGS += -DMPI
             LIBS += -lfmpi-pgi -lmpi-pgi 
endif

ifdef OpenMP
         CPPFLAGS += -D_OPENMP
           FFLAGS += -openmp
endif

ifdef DEBUG
           FFLAGS += -g -check bounds
else
           FFLAGS += -ip -O3
 ifeq ($(CPU),i686)
           FFLAGS += -pc80 -xW
 endif
 ifeq ($(CPU),x86_64)
           FFLAGS += -xW
 endif
endif

       clean_list += ifc* work.pc*
