local ac = call:_metatable()

function ac:welcome(p)
    local x = "call.a.ac:welcome"
    if p ~= nil then
        x = x.."="..tostring(p)
    end

    if debug > 0 then 
        call:log(x)
    end
    return x
end

function ac:undefined(p)
    local x = "call.a.ac:undefined"
    if p ~= nil then
        x = x.."="..tostring(p)
    end

    if debug > 0 then 
        call:log(x)
    end
    return x
end

return ac
