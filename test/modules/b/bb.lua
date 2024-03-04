local bb = call:_metatable()

function bb:welcome(p)
    local x = "call.b.bb:welcome"
    if p ~= nil then
        x = x.."="..tostring(p)
    end

    if debug > 0 then 
        call:log(x)
    end
    return x
end

function bb:undefined(p)
    local x = "call.b.bb:undefined"
    if p ~= nil then
        x = x.."="..tostring(p)
    end

    if debug > 0 then 
        call:log(x)
    end
    return x
end

return bb
