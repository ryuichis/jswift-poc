.PHONY: all clean build test xcodegen

all: build

clean:
	swift package clean

build:
	swift build

test: build
	swift test

xcodegen:
	swift package generate-xcodeproj --enable-code-coverage

setup_krakatau:
	wget https://github.com/Storyyeller/Krakatau/archive/master.zip
	unzip master.zip
	mv Krakatau-master Krakatau
