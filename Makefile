.PHONY: clean

INSTALL ?= /usr/bin/install
FORTUNESDIR ?= /usr/share/games/fortunes

philosoraptor.dat: philosoraptor
	strfile $^

philosoraptor: philosoraptor.in raptor.pl
	perl raptor.pl < $< > $@

install: philosoraptor.dat philosoraptor
	$(INSTALL) -m 666 $^ $(FORTUNESDIR)

clean:
	-rm -f philosoraptor philosoraptor.dat
