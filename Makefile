OS=$(shell lsb_release -si)
ARCH=$(shell uname -m | sed 's/x86_//;s/i[3-6]86/32/')
VER=$(shell lsb_release -sr)

build-prepare:
	cd photino.Native && make install-linux-dependencies.$(OS)

build-photino-native:
	cd photino.Native && make linux-dev

build-photino-net:
	cd photino.NET && dotnet build Photino.NET.sln

build-photino-test:
	cd photino.Test && dotnet build Photino.Test.csproj

run-photino-test: build-photino-test
	cp ./photino.Native/lib/dev/Photino.Native.so ./photino.Test/bin/Debug/net6.0 \
		&& cd photino.Test \
		&& dotnet run Photino.Test.csproj

all: build-photino-native
