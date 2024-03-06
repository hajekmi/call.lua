# Auto load lua modules
## Install
1. luarocks
```
luarocks install call
```
2. copy file to your project
```
make install
```

## Example for kamailio (install from luarocks)
```
call = require("call")
call:path('/etc/kamailio/modules/');
call:reload()

function ksr_request_route()
    call.mymodule:myfunc(params)
    call.mymodule.mysubmodule:myfunc(param)
end
```

## Example for kamailio (install manually)
```
call = dofile("/etc/kamailio/modules/call.lua")
call:path('/etc/kamailio/modules/');
call:reload()

function ksr_request_route()
    call.mymodule:myfunc(params)
    call.mymodule.mysubmodule:myfunc(param)
end
```

## Write own modules
Create dir /etc/kamailio/**modules** and create file /etc/kamailio/modules/**mymodule.lua**
```
local mymodule = call:_metatable()

function mymodule:myfunc(a)
    return 1
end

function mymodule:undefined(a)
    return 1
end
```

## Write own sub modules (with unlimited looping in the directories)
Create dir /etc/kamailio/**modules/mymodule** and create file /etc/kamailio/modules/**mymodule/mysubmodule.lua**
```
local mysubmodule = call:_metatable()

function mysubmodule:myfunc(a)
    return 1
end

function mysubmodule:undefined(a)
    return 1
end
```
Or you can see to test dir - with unlimited looping in the directories

## Run tests
```
make test
```

## Create new version
```
make createversion
```

## Functions
### path("./dir...")
Set path where modules stored

### path()
Get path where modules stored

### reload()
Clean loaded modules. And runs one complete cycle of garbage collection. 
Usage when reload kamailio.

### \_metatable()
Create and return empty module
```
local foo = call:_metatable()
```
or
```
local baa = {}
baa = call:_metatable(baa)
```

### \_help()
Print author and version

### \_version()
Get version

### \_getmem(p)
Get or print memory usage in kBytes. When p ~= nil then print to stdout
