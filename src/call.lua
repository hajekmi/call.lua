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
    path = "",
    version = "2024.2.28.2",
}

call = setmetatable(call, {
   __index = function(call, key)
        if call.classes[key] == nil then
            package.loaded[key] = nil

            local bck_package_path = package.path
            
            package.path = package.path .. ";"..call.path.."/?.lua"
            
            call.classes[key] = require(key)
            
            package.path = bck_package_path
        end

        return call.classes[key];
   end
})

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

function call:getClasses(k)
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
function call:load(module, key)
    if call.classes[module] == nil or call.classes[module].classes[key] == nil then
        package.loaded[key] = nil

        local bck_package_path = package.path
        
        package.path = package.path .. ";"..call.path.."/"..module.."/?.lua"

        local ret, m = ""
        ret, m = pcall(require, key)
        package.path = bck_package_path

        if ret then
            call.classes[module].classes[key] = m
        else
            return false, nil;
        end
    end

    return true, call.classes[module].classes[key];
end

-- create metatable for module
function call:metatable(name_class)
    local x = { classes = {}}

    local y = setmetatable(x, {
       __index = function(x, key)
            local ret, m = call:load(name_class, key)
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
    call.classes = {}
end

-- get version
function call:version()
    local x = call.version
    self:log(tostring(x))
end

return call
