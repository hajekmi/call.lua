local three = call:_metatable("three")

function three:welcome(a)
    local x = "call.three:welcome"
    if a ~= nil then
        x = x.."="..tostring(a)
    end

    if debug > 0 then 
        call:log(x)
    end
    return x
end

function three:undefined(a)
    local x = "call.three:undefined"
    if a ~= nil then
        x = x.."="..tostring(a)
    end

    if debug > 0 then 
        call:log(x)
    end
    return x
end

return three
