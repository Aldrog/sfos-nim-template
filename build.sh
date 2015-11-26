name='harbour-template'
projDir=$PWD
buildDir="../build-$name-$1"

mkdir -p $buildDir
cp -r rpm $buildDir/rpm
cd $buildDir

echo '
name='$name'

$(name):	'$projDir'/src/*.nim
	nim c -o:"$(PWD)/$(name)" '$projDir'/src/main.nim

install:	$(name) '$projDir'/lib/lib*.so '$projDir'/qml/*.qml '$projDir'/$(name).desktop '$projDir'/icons/*
	mkdir -p $(DESTDIR)/usr/bin
	mkdir -p $(DESTDIR)/usr/share/$(name)
	mkdir -p $(DESTDIR)/usr/share/applications
	mkdir -p $(DESTDIR)/usr/share/icons/hicolor
	cp $(name) $(DESTDIR)/usr/bin/$(name)
	cp -r '$projDir'/qml $(DESTDIR)/usr/share/$(name)/
	cp -r '$projDir'/lib $(DESTDIR)/usr/share/$(name)/
	cp '$projDir'/$(name).desktop $(DESTDIR)/usr/share/applications/$(name).desktop
	for resol in 86x86 108x108 128x128 256x256; do \
		RESDIR="$(DESTDIR)/usr/share/icons/hicolor/$$resol/apps" ; \
		mkdir -p $$RESDIR; \
		cp '$projDir'/icons/$$resol/$(name).png $$RESDIR/$(name).png; \
	done

clean:	$(name)
	#rm $(name)
	#rm documentation.list
' > Makefile

mb2 -t SailfishOS-$1 build

