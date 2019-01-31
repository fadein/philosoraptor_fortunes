.PHONY: clean all install uninstall


RM          ?= /usr/bin/rm
SUDO        ?= /usr/bin/sudo
INSTALL     ?= /usr/bin/install
FORTUNESDIR ?= /usr/share/games/fortunes

all: philosoraptor.dat philosoraptor-o.dat

philosoraptor.dat: philosoraptor
	strfile $^

philosoraptor-o.dat: philosoraptor-o
	strfile -x $^

philosoraptor: philosoraptor.in
	perl raptor.pl < $< > $@

philosoraptor-o: philosoraptor-o.in
	perl raptor.pl -13 < $< > $@

install: philosoraptor.dat philosoraptor philosoraptor-o.dat philosoraptor-o
	$(SUDO) $(INSTALL) -m 666 $^ $(FORTUNESDIR)

uninstall:
	+$(SUDO) $(RM) -f \
		$(FORTUNESDIR)/philosoraptor.dat \
		$(FORTUNESDIR)/philosoraptor \
		$(FORTUNESDIR)/philosoraptor-o.dat \
		$(FORTUNESDIR)/philosoraptor-o

clean:
	-rm -f philosoraptor philosoraptor.dat philosoraptor-o.dat philosoraptor-o
