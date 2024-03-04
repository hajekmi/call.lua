local aab = call:_metatable()

function aab:welcome(p)
    local x = "call.a.aa.aab:welcome"
    if p ~= nil then
        x = x.."="..tostring(p)
    end

    if debug > 0 then 
        call:log(x)
    end
    return x
end

function aab:undefined(p)
    local x = "call.a.aa.aab:undefined"
    if p ~= nil then
        x = x.."="..tostring(p)
    end

    if debug > 0 then 
        call:log(x)
    end
    return x
end

return aab
