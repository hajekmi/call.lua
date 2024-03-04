local abb = call:_metatable()

function abb:welcome(p)
    local x = "call.a.ab.abb:welcome"
    if p ~= nil then
        x = x.."="..tostring(p)
    end

    if debug > 0 then 
        call:log(x)
    end
    return x
end

function abb:undefined(p)
    local x = "call.a.ab.abb:undefined"
    if p ~= nil then
        x = x.."="..tostring(p)
    end

    if debug > 0 then 
        call:log(x)
    end
    return x
end

return abb
