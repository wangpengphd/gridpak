#
# Include file for Absoft compiler on Mac (Darwin)
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
               FC := f90
           FFLAGS := -N11 -YEXT_NAMES=LCS -YEXT_SFX=_ -YCFRL=1 -w
              CPP := /usr/bin/cpp
         CPPFLAGS := -P -DMAC -traditional
            CLEAN := Bin/cpp_clean
               LD := ncargf90
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

    NETCDF_INCDIR ?= /usr/local/include
    NETCDF_LIBDIR ?= /usr/local/lib

         CPPFLAGS += -I$(NETCDF_INCDIR)
             LIBS := -L$(NETCDF_LIBDIR) -lnetcdf -lU77

ifdef ARPACK
    ARPACK_LIBDIR ?= /usr/local/lib
             LIBS += -L$(ARPACK_LIBDIR) -larpack
endif

ifdef MPI
         CPPFLAGS += -DMPI
endif

ifdef OpenMP
         CPPFLAGS += -D_OPENMP
endif

ifdef DEBUG
           FFLAGS += -g
else
           FFLAGS += -O3
endif
