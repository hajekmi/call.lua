# Auto load lua modules
## Example for kamailio
```
call = dofile("/etc/kamailio/modules/call.lua")
call:path('/etc/kamailio/modules/');
call:reload()

function ksr_request_route()
    call.mymodule:myfunc(params)
end
```

## Write own modules
Create dir /etc/kamailio/**modules** and create file /etc/kamailio/modules/**mymodule.lua**
```
local mymodule = call:_metatable("mymodule")

function mymodule:myfunc(a)
    return 1
end

function mymodule:undefined(a)
    return 1
end
```

## Write own sub modules
Create dir /etc/kamailio/**modules/mymodule** and create file /etc/kamailio/modules/**mymodule/mysubmodule.lua**
```
local mysubmodule = call:_metatable("mysubmodule")

function mysubmodule:myfunc(a)
    return 1
end

function mysubmodule:undefined(a)
    return 1
end
```

## Run tests
```
make test
```

## Create new version
```
make createversion
```

## Functions
### reload
Clean loaded modules. Usage when reload kamailio.

### help
Print author and version

### path
Set path where modules stored

### \_metatable(name)
Create and return empty module
```
local foo = call:_metatable("foo")
```
