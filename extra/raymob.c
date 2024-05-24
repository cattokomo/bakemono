#include <lua.h>
#include <lauxlib.h>

#include "./extra/raymob_binding.c"

int luaopen_raymob(lua_State *L)
{
  lua_newtable(L);

  lua_pushstring(L, "bind_entries");
  lua_pushlightuserdata(L, bind_entries);
  lua_settable(L, -3);

  return 1;
}
