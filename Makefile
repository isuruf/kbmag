# General makefile for GAP4 KBMAG share package -
# all executables are put into the bin directory.
SHELL = /bin/sh
SYSTEM = SYSTEMV
RM = /bin/rm
BIN = bin/sparc-sun-solaris2.7-gcc

CC = gcc
COPTS = -O

targets: all

bindir:
	if test ! -d bin;  then mkdir bin;  fi
	if test ! -d bin/sparc-sun-solaris2.7-gcc;  then mkdir bin/sparc-sun-solaris2.7-gcc;  fi

all: bindir
	cd standalone/lib; $(MAKE) CC="$(CC)" COPTS="$(COPTS)"
	cd standalone/src;\
	$(MAKE) CC="$(CC)" BIN="../../$(BIN)" SYSTEM="$(SYSTEM)" COPTS="$(COPTS)"

clean:
	cd standalone/lib; $(MAKE) clean
	cd standalone/src; $(MAKE) clean

distclean:
	cd standalone/lib; $(MAKE) clean
	cd standalone/src; $(MAKE) clean
	$(RM) -f $(BIN)/*
	cd standalone/ag_data; $(RM) -f *.* 
	cd standalone/kb_data; $(RM) -f *.* 
	cd standalone/fsa_data; $(RM) -f *.* 
	cd standalone/subgp_data; $(RM) -f *.[a-r,t-z]* *.suc* *.sub*.* *.ec
	cd standalone/doc; $(RM) -f *.aux *.toc *.log *.dvi
	cd doc; $(RM) -f *.aux *.toc *.log *.dvi

test:
	cd standalone/kb_data; ../../$(BIN)/kbprog nilp2; rm nilp2.*
	cd standalone/ag_data; ../../$(BIN)/autgroup 235; ../../$(BIN)/fsacount 235.wa; rm 235.*
	cd standalone/subgp_data; ../../$(BIN)/autcos -p ab2; ../../$(BIN)/fsacount ab2.cos.wa;\
		../../$(BIN)/autgroup -silent ab2; ../../$(BIN)/gpsubwa ab2;\
		rm ab2.[dgw]* ab2.sub.* ab2.suc* ab2.cos*

texdoc: 
	cd doc;\
        tex manual;bibtex manual;\
	../../../doc/manualindex manual;tex manual;tex manual;