# SailfishOS Nim Template Project
This is a template for SailfishOS app in Nim language.
## How it works
This template makes use of [nimqml](https://github.com/filcuc/nimqml) module which is built on top of [DOtherSide](https://github.com/filcuc/DOtherSide) library.  
This repository includes stripped version of DOtherSide sources (without dependency on QtWidgets so an app you build will be able to pass harbour check)
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
echo 'PATH=$PATH:'$HOME'/.nimble/bin' >> ~/.bashrc
```
* Install nimqml module:
```
nimble install nimqml
```
### Build
* In build engine launch build.sh with desired architecture:
```
sh build.sh i486
```

This will produce rpm package in ../build-projname-arch/RPMS

## TODO
* Integrate mapplauncherd for view caching (may be quite tricky)
* Support debug/release build modes
* Add how-to-rename instructions
