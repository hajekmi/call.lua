local aba = call:_metatable()

function aba:welcome(p)
    local x = "call.a.ab.aba:welcome"
    if p ~= nil then
        x = x.."="..tostring(p)
    end

    if debug > 0 then 
        call:log(x)
    end
    return x
end

function aba:undefined(p)
    local x = "call.a.ab.aba:undefined"
    if p ~= nil then
        x = x.."="..tostring(p)
    end

    if debug > 0 then 
        call:log(x)
    end
    return x
end

return aba
