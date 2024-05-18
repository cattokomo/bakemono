ifeq ($(OS),Windows_NT)
	EXT= .exe
endif

LUA_IN= $(shell find bm/ -type f -name '*.lua')
LUAC_OUT= $(patsubst %.lua,%.luac,$(LUA_IN))

all: $(LUAC_OUT)

$(LUAC_OUT): $(LUA_IN)

%.luac: %.lua
	LUA_PATH=./raylib-lua/luajit/src/?.lua ./raylib-lua/luajit/src/luajit -b $< $@

build: $(LUAC_OUT)
	zip bakemono.zip $(shell find bm) main.lua
	./raylib-lua/raylua_r bakemono.zip
	mv bakemono_out bakemono$(EXT)
	cp bakemono$(EXT) gbakemono$(EXT)

clean:
	rm -f $(LUAC_OUT)
	rm -f *bakemono*
