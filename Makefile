ifeq ($(OS),Windows_NT)
	EXT= .exe
endif

SO_EXT= .so
ifeq ($(OS),Windows_NT)
	SO_EXT= .dll
else ifeq ($(shell uname -s),Darwin)
	SO_EXT= .dylib
endif

LUA_IN= $(shell find bm/ -type f -name '*.lua')
LUAC_OUT= $(patsubst %.lua,%.luac,$(LUA_IN))

BIN_ZIP= bakemono.zip
BIN= bakemono gbakemono

LUV_DEPS= deps/luv/build/libluv.a deps/luv/build/deps/libuv/libuv.a

all: $(BIN)

$(LUV_DEPS):
	cd deps/luv && \
		LUA_BUILD_TYPE=System WITH_LUA_ENGINE=LuaJIT BUILD_STATIC_LIBS=On make

raylua: $(LUV_DEPS)
	patch --merge -p1 -d raylib-lua <extra/extra-src-raylua.patch
	make -C raylib-lua
	cp raylib-lua/raylua_r raylua

$(LUAC_OUT): $(LUA_IN)

$(BIN_ZIP): $(LUAC_OUT) $(shell find bm/assets) $(shell find bm -name '*$(SO_EXT)') main.lua
	zip bakemono.zip $^

$(BIN): raylua $(BIN_ZIP)
	./raylua bakemono.zip
	mv bakemono_out bakemono$(EXT)
	cp bakemono$(EXT) gbakemono$(EXT)

%.luac: %.lua
	LUA_PATH=./raylib-lua/luajit/src/?.lua ./raylib-lua/luajit/src/luajit -b $< $@

clean:
	rm -f $(LUAC_OUT)
	rm -f *bakemono*
