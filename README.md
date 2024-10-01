# Auto load lua modules
Automatic loading of files as looped modules.
For example, calling **call.module1.submodule2.submodule3:anyfunc()** will load the following files automatically:
- module1.lua -> create table call.**module1**
- module1/submodule2.lua -> create table call.**module1.submodule2**
- module1/submodule2/submodule3.lua - create table call.**module1.submodule2.submodule3** and return result from **anyfunc()**

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

return mymodule
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

return mysubmodule
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

### \_version(p)
Get version. When p ~= nil then print to stdout

### \_getmem(p)
Get or print memory usage in kBytes. When p ~= nil then print to stdout
