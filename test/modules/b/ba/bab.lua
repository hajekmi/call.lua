local bab = call:_metatable()

function bab:welcome(p)
    local x = "call.b.ba.bab:welcome"
    if p ~= nil then
        x = x.."="..tostring(p)
    end

    if debug > 0 then 
        call:log(x)
    end
    return x
end

function bab:undefined(p)
    local x = "call.b.ba.bab:undefined"
    if p ~= nil then
        x = x.."="..tostring(p)
    end

    if debug > 0 then 
        call:log(x)
    end
    return x
end

return bab
