-- autoload for Lua/KEMI

--[[
kamailio.cfg
call = dofile("/etc/kamailio/modules/call.lua")
call:path('/etc/kamailio/modules/');
call:reload()

--]]
-- inability to call KSR immediately after loading this module

call = {
    classes = {},
    path = "./",
    version = "2024.3.1",
}

call = setmetatable(call, {
   __index = function(call, key)
        if call.classes[key] == nil then
            local path = call.path.."/"..key..".lua"

            local ret, m = ""
            ret, m = pcall(dofile, path)

            if ret then
               call:_set(key, m, nil)
            else
                return false
            end
        end

        return call:_get(key, nil)
   end
})

function call:_set(key, p, module)
    if module ~= nil then
        call.classes[module][key] = 1
        call[module][key] = p
    else
        call.classes[key] = {}
        call[key] = p
    end
end

function call:_get(key, module)
    if module ~= nil then
        return call[module][key]
    else
        return call[key]
    end
end

function call:help()
    self:log("Autoload module for Lua/KEMI - "..call.version)
    self:log("Powered by Michal Hajek <michal.hajek@daktela.com>")
end

-- unable run KSR after kamailio load.
function call:log(s)
    print(s)
    if KSR ~= nil then
        KSR.xlog.xinfo(s.."\n")
    end
end

function call:_getClasses(k)
    if k ~= nil then
        return call.classes[k]
    else
        return call.classes
    end
end

-- set path, where lua modules find
function call:path(p)
    call.path = p
end

-- load third modules in dir
function call:_load(module, key)
    if call.classes[module] == nil or call.classes[module][key] == nil then

        local path = call.path.."/"..module.."/"..key..".lua"

        local ret, m = ""
        ret, m = pcall(dofile, path)

        if ret then
            call:_set(key, m, module)
        else
            return false, nil;
        end
    end

    return true, call:_get(key, module)
end

-- create metatable for module
function call:_metatable(name_class)
    local x = {}

    local y = setmetatable(x, {
       __index = function(x, key)
            local ret, m = call:_load(name_class, key)
            if ret then
                return m
            else
                return x.undefined
            end 
       end
    })

    return y
end

-- run this reload from main loop after run reload from RPC
function call:reload()
    -- unable make KSR.xlog.xinfo()
    for k,_ in pairs(call:_getClasses()) do
        call[k] = nil
        package.loaded[k] = nil
    end
    call.classes = {}
end

-- get version
function call:_version()
    local x = call.version
    self:log(tostring(x))
    return x
end

return call
