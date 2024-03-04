local baa = call:_metatable()

function baa:welcome(p)
    local x = "call.b.ba.baa:welcome"
    if p ~= nil then
        x = x.."="..tostring(p)
    end

    if debug > 0 then 
        call:log(x)
    end
    return x
end

function baa:undefined(p)
    local x = "call.b.ba.baa:undefined"
    if p ~= nil then
        x = x.."="..tostring(p)
    end

    if debug > 0 then 
        call:log(x)
    end
    return x
end

return baa
