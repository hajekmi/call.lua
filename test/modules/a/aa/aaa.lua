local aaa = call:_metatable()

function aaa:welcome(p)
    local x = "call.a.aa.aaa:welcome"
    if p ~= nil then
        x = x.."="..tostring(p)
    end

    if debug > 0 then 
        call:log(x)
    end
    return x
end

function aaa:undefined(p)
    local x = "call.a.aa.aaa:undefined"
    if p ~= nil then
        x = x.."="..tostring(p)
    end

    if debug > 0 then 
        call:log(x)
    end
    return x
end

return aaa
