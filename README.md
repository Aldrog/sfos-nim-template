# SailfishOS Nim Template Project
This is a template for SailfishOS app in Nim language.
## How it works
This template makes use of [nimqml](https://github.com/filcuc/nimqml) module which is built on top of [DOtherSide](https://github.com/filcuc/DOtherSide) library.  
This repository includes stripped version of DOtherSide sources (without dependency on QtWidgets so an app you build will be able to pass harbour validator). Actually, you also need to delete a part of nimqml (maybe I will include it to this repository because of that)
## How to build
### Preparation
* Log into Mer build engine. It's well described on https://sailfishos.org/develop/sdk-overview/develop-faq/
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
* And for mersdk if you want a working nimble installation:
```
cd csources
sh build.sh
cd ..
bin/nim c koch
./koch boot -d:release
./koch install /usr/local/bin
```
* Install nimble package manager:
```
cd
git clone https://github.com/nim-lang/nimble.git
cd nimble
nim c -r src/nimble install
echo 'PATH=$PATH:'$HOME'/.nimble/bin' >> ~/.bashrc
```
* Install nimqml module:
```
nimble install nimqml
```
### Build
* In build engine cd into project directory and launch build.sh with desired architecture and build mode like this:
```
sh build.sh i486 debug
```

This will produce an rpm package in ../build-projname-arch-mode/RPMS

## TODO
* Add how-to-rename instructions
* Integrate with mapplauncherd for view caching (I'm neither sure if it's possible nor if it's useful so this entry is in question)
