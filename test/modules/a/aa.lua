local aa = call:_metatable()

function aa:welcome(p)
    local x = "call.a.aa:welcome"
    if p ~= nil then
        x = x.."="..tostring(p)
    end

    if debug > 0 then 
        call:log(x)
    end
    return x
end

function aa:undefined(p)
    local x = "call.a.aa:undefined"
    if p ~= nil then
        x = x.."="..tostring(p)
    end

    if debug > 0 then 
        call:log(x)
    end
    return x
end

function aa:savevalue(p)
    aa.value = p

    local x = "call.a.aa:savevalue"
    if p ~= nil then
        x = x.."="..tostring(p)
    end

    if debug > 0 then 
        call:log(x)
    end
    return x
end

function aa:getvalue()
    local p = self.value
    local x = "call.a.aa:getvalue"
    if p ~= nil and type(p) == "string" then
        x = x.."="..tostring(p)
    end

    if debug > 0 then 
        call:log(x)
    end
    return x
end

return aa
