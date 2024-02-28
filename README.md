= Auto load lua modules
== Example for kamailio
call = dofile("/etc/kamailio/modules/call.lua")
call:path('/etc/kamailio/modules/');
call:reload()

function ksr_request_route()
    call.mymodule:myfunc(params)
end

== Test
cd test/
lua test.lua
