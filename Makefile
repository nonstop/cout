NAME=cout
VERSION=1.0.6
PREFIX=/usr

DOCS='ChangeLog LICENSE README.md'

all:
	@sed -i -s "s/^NAME.*/NAME='$(NAME)'/g" ./cout
	@sed -i -s "s/^VERSION.*/VERSION='$(VERSION)'/g" ./cout

install-bin:
	mkdir -p $(DESTDIR)/$(PREFIX)/bin
	cat cout > $(DESTDIR)/$(PREFIX)/bin/cout
	chmod +x $(DESTDIR)/$(PREFIX)/bin/cout

install-docs:
	mkdir -p $(DESTDIR)/$(PREFIX)/share/doc/$(NAME)-$(VERSION)
	cp -a $(DOCS) $(DESTDIR)/$(PREFIX)/share/doc/$(NAME)-$(VERSION)

install-data:
	mkdir -p $(DESTDIR)/$(PREFIX)/share/$(NAME)-$(VERSION)
	cp -a data/* $(DESTDIR)/$(PREFIX)/share/$(NAME)-$(VERSION)

install: install-bin install-docs install-data

dist:
	@EXCLUDE=`mktemp` && find . -name .git > $EXCLUDE \
	&& echo "$(NAME)-$(VERSION).tar.bz2" >> $EXCLUDE \
	&& tar -X $EXCLUDE -cjf $(NAME)-$(VERSION).tar.bz2 .

