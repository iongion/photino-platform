OS=$(shell lsb_release -si)
ARCH=$(shell uname -m | sed 's/x86_//;s/i[3-6]86/32/')
VER=$(shell lsb_release -sr)

build-prepare:
	cd photino.Native && make install-linux-dependencies.$(OS)

build-photino-native:
	cd photino.Native && make linux-dev

build-photino-net:
	cd photino.NET && dotnet build Photino.NET.sln -c Release /p:Platform=x64

build-photino-test:
	cd photino.Test && dotnet build Photino.Test.csproj -c Release /p:Platform=x64

run-photino-test: build-photino-native build-photino-test
	cd photino.Test && dotnet run Photino.Test.csproj -c Release /p:Platform=x64

all: build-photino-native
