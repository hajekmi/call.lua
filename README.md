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
Create dir /etc/kamailio/modules/ and create file /etc/kamailio/modules/mymodule.lua
```
mymodule = call:metatable("mymodule")

function mymodule:myfunc(a)
    return 1
end

```

## Run tests
```
cd test/
lua test.lua
```
