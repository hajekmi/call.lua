two = call:metatable("two")

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
