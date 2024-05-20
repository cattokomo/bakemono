ifeq ($(OS),Windows_NT)
	EXT= .exe
endif

LUA_IN= $(shell find bm/ -type f -name '*.lua')
LUAC_OUT= $(patsubst %.lua,%.luac,$(LUA_IN))

BIN_ZIP= bakemono.zip
BIN= bakemono gbakemono

all: $(BIN)

$(LUAC_OUT): $(LUA_IN)

$(BIN_ZIP): $(LUAC_OUT) $(shell find bm) main.lua
	zip bakemono.zip $^

$(BIN): $(BIN_ZIP)
	raylib-lua/raylua_r bakemono.zip
	mv bakemono_out bakemono$(EXT)
	cp bakemono$(EXT) gbakemono$(EXT)

%.luac: %.lua
	LUA_PATH=./raylib-lua/luajit/src/?.lua ./raylib-lua/luajit/src/luajit -b $< $@

clean:
	rm -f $(LUAC_OUT)
	rm -f *bakemono*
