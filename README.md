# SailfishOS Nim Template Project
This is a template for SailfishOS app in Nim language.
## How to build
### Preparation
* Log into Mer build engine. It's described on https://sailfishos.org/develop/sdk-overview/develop-faq/
* Install Nim compiler for both targets:
```
git clone https://github.com/nim-lang/Nim.git
cd Nim
git clone --depth 1 git://github.com/nim-lang/csources
cd csources
sb2 -t SailfishOS-armv7hl -m sdk-install -R sh build.sh
cd ..
sb2 -t SailfishOS-armv7hl -m sdk-install -R bin/nim c koch
sb2 -t SailfishOS-armv7hl -m sdk-install -R ./koch boot -d:release
sb2 -t SailfishOS-armv7hl -m sdk-install -R ./koch install /usr/local/bin
cd csources
sb2 -t SailfishOS-i486 -m sdk-install -R sh build.sh
cd ..
sb2 -t SailfishOS-i486 -m sdk-install -R bin/nim c koch
sb2 -t SailfishOS-i486 -m sdk-install -R ./koch boot -d:release
sb2 -t SailfishOS-i486 -m sdk-install -R ./koch install /usr/local/bin
```
* Install nimble package manager:
```
git clone https://github.com/nim-lang/nimble.git
cd nimble
sb2 -t SailfishOS-i486 -m sdk-install -R nim c -r src/nimble install
```
* Install nimqml module:
```
sb2 -t SailfishOS-i486 -m sdk-install -R nimble install nimqml
```
* Install cmake 3.x for both targets.
* Get DOtherSide:
```
git clone https://github.com/filcuc/DOtherSide.git
```
* Build DOtherSide for desired platform. For i486:
```
mkdir build-i486
sb2 -t SailfishOS-i486 -m sdk-build cmake-3.4 -DCMAKE_BUILD_TYPE=Release
sb2 -t SailfishOS-i486 -m sdk-build make
```
* Copy lib/libDOtherSide.so to `project directory`/lib

### Build
* In build engine launch build.sh with desired architecture:
```
sh build.sh i486
```

This will produce rpm package in ../build-projname-arch/RPMS

## TODO
* Automate DOtherSide build
* Include stripped DOtherSide sources to repository (for passing harbour test)
* Port to cmake 2.8 to get rid of cmake 3.x dependency
* Integrate libsailfishapp for view caching (may be quite tricky)
* Maybe something I forgot about
