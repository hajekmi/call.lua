package = "call"
version = "2024.3.4.2-1"
rockspec_format = "3.0"
source = {
   url = "git+https://github.com/hajekmi/call.lua.git",
   tag = "2024.3.4.1",
}
description = {
   detailed = "Autoload modules",
   homepage = "https://github.com/hajekmi/call.lua",
   license = "FREE"
}
dependencies = {
	"lua >= 5.3"
}
build = {
   type = "builtin",
   modules = {
      call = "src/call.lua"
   }
}
test = {
   type = "command",
   command = "make test",
}
