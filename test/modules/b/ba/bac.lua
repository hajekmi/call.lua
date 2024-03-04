local bac = call:_metatable()

function bac:welcome(p)
    local x = "call.b.ba.bac:welcome"
    if p ~= nil then
        x = x.."="..tostring(p)
    end

    if debug > 0 then 
        call:log(x)
    end
    return x
end

function bac:undefined(p)
    local x = "call.b.ba.bac:undefined"
    if p ~= nil then
        x = x.."="..tostring(p)
    end

    if debug > 0 then 
        call:log(x)
    end
    return x
end

return bac
