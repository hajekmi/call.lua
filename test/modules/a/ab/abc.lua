local abc = call:_metatable()

function abc:welcome(p)
    local x = "call.a.ab.abc:welcome"
    if p ~= nil then
        x = x.."="..tostring(p)
    end

    if debug > 0 then 
        call:log(x)
    end
    return x
end

function abc:undefined(p)
    local x = "call.a.ab.abc:undefined"
    if p ~= nil then
        x = x.."="..tostring(p)
    end

    if debug > 0 then 
        call:log(x)
    end
    return x
end

return abc
