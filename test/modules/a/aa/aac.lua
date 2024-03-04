local aac = call:_metatable()

function aac:welcome(p)
    local x = "call.a.aa.aac:welcome"
    if p ~= nil then
        x = x.."="..tostring(p)
    end

    if debug > 0 then 
        call:log(x)
    end
    return x
end

function aac:undefined(p)
    local x = "call.a.aa.aac:undefined"
    if p ~= nil then
        x = x.."="..tostring(p)
    end

    if debug > 0 then 
        call:log(x)
    end
    return x
end

return aac
