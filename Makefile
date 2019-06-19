UXP_SRC := uxp/uxp-2019-06-12.tgz
MOZCONFIG_TXT := mozconfig.txt

all: build/xulrunner.zip

build:
	mkdir -p build

build/xulrunner.zip: build build/UXP-master/obj-i686-pc-mingw32/dist/bin
	(cd build/UXP-master/obj-i686-pc-mingw32/dist/bin; zip -9 -r $(abspath $@) .)

build/UXP-master: build
	cd build; tar xzf $(UXP_SRC)

build/UXP-master/.mozconfig: $(MOZCONFIG_TXT)
	cp $(MOZCONFIG_TXT) $@

build/UXP-master/obj-i686-pc-mingw32/dist/bin: build/UXP-master build/UXP-master/.mozconfig
	cd build/UXP-master; ./mach build
