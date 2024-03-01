local one = call:_metatable("one")

function one:welcome(a)
    local x = "call.one:welcome"
    if a ~= nil then
        x = x.."="..tostring(a)
    end
    
    if debug > 0 then 
        call:log(x)
    end
    return x
end


function one:undefined(a)
    local x = "call.one:undefined"
    if a ~= nil then
        x = x.."="..tostring(a)
    end

    if debug > 0 then 
        call:log(x)
    end
    return x
end

return one
