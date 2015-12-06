name='harbour-template'
projDir=$PWD

# Build DOtherSide
dosBuildDir="lib/DOtherSide/build-$1"
mkdir -p $dosBuildDir
cd $dosBuildDir
sb2 -t SailfishOS-$1 -m sdk-build cmake -DCMAKE_BUILD_TYPE=$2 ..
sb2 -t SailfishOS-$1 -m sdk-build make
cd $projDir

# Build app
buildDir="$projDir/../build-$name-$1-$2"
mkdir -p $buildDir
mkdir $buildDir/lib
cp -r rpm $buildDir/
cp $dosBuildDir/lib/libDOtherSide.so $buildDir/lib/libDOtherSide.so
cd $buildDir
echo '
'$name':	'$projDir'/src/*.nim
	nim c -o:"'$buildDir'/'$name'" -l:"-L./lib" -d:'$2' '$projDir'/src/main.nim

install:	'$name' '$projDir'/qml/*.qml '$projDir'/'$name'.desktop '$projDir'/icons/*
	mkdir -p $(DESTDIR)/usr/bin
	mkdir -p $(DESTDIR)/usr/share/'$name'
	mkdir -p $(DESTDIR)/usr/share/applications
	mkdir -p $(DESTDIR)/usr/share/icons/hicolor
	cp '$name' $(DESTDIR)/usr/bin/'$name'
	cp -r '$projDir'/qml $(DESTDIR)/usr/share/'$name'/
	cp -r '$buildDir'/lib $(DESTDIR)/usr/share/'$name'/
	cp '$projDir'/'$name'.desktop $(DESTDIR)/usr/share/applications/'$name'.desktop
	for resol in 86x86 108x108 128x128 256x256; do \
		RESDIR="$(DESTDIR)/usr/share/icons/hicolor/$$resol/apps" ; \
		mkdir -p $$RESDIR; \
		cp '$projDir'/icons/$$resol/'$name'.png $$RESDIR/'$name'.png; \
	done

clean:	'$name'
	#rm '$name'
	#rm documentation.list
' > Makefile

mb2 -t SailfishOS-$1 build

