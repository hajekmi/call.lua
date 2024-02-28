--[[
three = { classes = {}}

three = setmetatable(three, {
   __index = function(three, key)        
        local ret, m = call:load("three", key)
        if ret then
            return m
        else
            return three.undefined
        end
   end
})
--]]
three = call:metatable("three")


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
