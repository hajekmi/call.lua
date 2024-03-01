local abc = call:_metatable("abc")

function abc:welcome(a)
    local x = "call.three.abc:welcome"
    if a ~= nil then
        x = x.."="..tostring(a)
    end

    if debug > 0 then 
        call:log(x)
    end
    return x
end

function abc:undefined(a)
    local x = "call.three.abc:undefined"
    if a ~= nil then
        x = x.."="..tostring(a)
    end

    if debug > 0 then 
        call:log(x)
    end
    return x
end

return abc
