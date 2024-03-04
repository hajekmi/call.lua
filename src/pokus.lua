local x = {"111","222","333"}
local a = "ahoj"
local y = x
y[#y + 1] = a


for k,v in pairs(y) do
    print(k..": "..v)
end
