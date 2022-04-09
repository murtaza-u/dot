PREFIX ?= /usr/local
CC ?= cc
LDFLAGS = -lX11

output: lemonaid.c config.h
	${CC}  lemonaid.c $(LDFLAGS) -o lemonaid

clean:
	rm -f *.o *.gch lemonaid

install: output
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	install -m 0755 lemonaid $(DESTDIR)$(PREFIX)/bin/lemonaid

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/lemonaid
