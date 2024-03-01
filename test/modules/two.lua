local two = call:_metatable("two")

function two:welcome(a)
    local x = "call.two:welcome"
    if a ~= nil then
        x = x.."="..tostring(a)
    end

    if debug > 0 then 
        call:log(x)
    end
    return x
end

function two:savevalue(a)
    self.value = tostring(a)
    local x = "call.two:savevalue"
    if a ~= nil then
        x = x.."="..tostring(a)
    end

    if debug > 0 then 
        call:log(x)
    end
    return x
end

function two:getvalue()
    local a = self.value
    local x = "call.two:getvalue"
    if a ~= nil and type(a) == "string" then
        x = x.."="..tostring(a)
    end

    if debug > 0 then 
        call:log(x)
    end
    return x
end


function two:undefined(a)
    local x = "call.two:undefined"
    if a ~= nil then
        x = x.."="..tostring(a)
    end

    if debug > 0 then 
        call:log(x)
    end
    return x
end

return two
