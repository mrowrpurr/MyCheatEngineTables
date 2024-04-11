local ce_lua_package_path = os.getenv("CE_LUA_PACKAGE_PATH")

package.path = ce_lua_package_path .. ";" .. package.path

require("Plugins.MrowrPurrPlugin").autorun()
