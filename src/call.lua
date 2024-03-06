-- autoload for Lua/KEMI

--[[
kamailio.cfg
call = dofile("/etc/kamailio/modules/call.lua")
call:path('/etc/kamailio/modules/');
call:reload()

--]]
-- inability to call KSR immediately after loading this module

call = {
    _c = {
        path = "./",
        version = "2024.3.6.2",
        modules_path = {}, -- path to the namespace
        modules_name = {}, -- modules name with same namespace (this modules will be clean after reload)
        name = "", -- actual name module in the namespace
    },
}

function call:_help()
    self:log("Autoload module for Lua/KEMI - "..call._getversion())
    self:log("Powered by Michal Hajek <michal.hajek@daktela.com>")
end

-- unable run KSR after kamailio load.
function call:log(s)
    print(s)
    if KSR ~= nil then
        KSR.xlog.xinfo(s.."\n")
    end
end

-- set path, where lua modules find
function call:path(p)
    if p == nil then
        return call._c.path, true
    else
        call._c.path = p
        return call._c.path, true
    end
end

-- return path to the module namespace
function call:_preparepath(modules, key)
    local path = call._c.path
    for i,v in pairs(modules) do
        path = path.."/"..v
    end
    path = path.."/"..key..".lua"
    return path
end

function call:undefined()
    return false
end

-- copy table from (src) to dst table
function call:_copytable(src,dst)
    for k,v in pairs(src) do
        dst[k] = v
    end
    return dst
end

-- appent item to indexed array
function call:_appendindextable(t, item)
    local count = #t + 1
    t[count] = item
    return t
end

-- load third modules in dir
function call:_load(actual_module_tbl, key)
        local path =  call:_preparepath(actual_module_tbl._c.modules_path, key)

        local ret, new_module_tbl = ""
        ret, new_module_tbl = pcall(dofile, path)

        if ret then
            new_module_tbl._c["modules_path"] = call:_copytable(actual_module_tbl._c["modules_path"], new_module_tbl._c["modules_path"])

            new_module_tbl._c.modules_path = call:_appendindextable(new_module_tbl._c.modules_path, key)

            new_module_tbl._c["name"] = key

            actual_module_tbl[key] = new_module_tbl

            actual_module_tbl._c["modules_name"][key] = key

            return true, actual_module_tbl[key]
        else
            return false, nil;
        end
end

-- create metatable for module
function call:_metatable(actual_module_tbl)
    if actual_module_tbl == nil then
        actual_module_tbl = {}
    end
    if actual_module_tbl._c == nil then
        actual_module_tbl["_c"] = {}
    end
    if actual_module_tbl._c.modules_path == nil then
        actual_module_tbl._c["modules_path"] = {}
    end
    if actual_module_tbl._c.modules_name == nil then
        actual_module_tbl._c["modules_name"] = {}
    end
    if actual_module_tbl._c.name == nil then
        actual_module_tbl._c["name"] = ""
    end

    actual_module_tbl = setmetatable(actual_module_tbl, {
       __index = function(actual_module_tbl, key)
            
            local ret, m = call:_load(actual_module_tbl, key)
            if ret then
                return m
            else
                return actual_module_tbl.undefined
            end 
       end
    })

    return actual_module_tbl
end

-- run this reload from main loop after run reload from RPC
function call:reload()
    -- unable make KSR.xlog.xinfo()
    for k,v in pairs(call._c["modules_name"]) do
        call[v] = nil
        package.loaded[v] = nil
    end
    call._c["modules_name"] = {}
    call._c["modules_path"] = {}
end

-- get version
function call:_version()
    local x = call._c.version
    self:log(tostring(x))
    return x
end

-- return count array/hash
function call:_count(a)
    local count = 0
    if type(a) == "table" then
        for _ in pairs(a) do
            count = count + 1
        end
    end
    return count
end

-- print debug table (array or hash)
function call:_debugtable(a)
    print("  .......");
    local l = call:_count(a)
    if l == 0 then
        print("    _empty_")
    else
        for k,v in pairs(a) do
            print("    ["..k.."]: "..tostring(v))
        end
    end
    print("  .......");
end

call = call:_metatable(call)

return call
