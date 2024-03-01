
call = dofile("../src/call.lua")
call:path('./modules/');
call:reload()

debug = 0
count = {
    errors = 0,
    oks = 0,
}

time = {
    0, -- 1.
    0  -- 2.
}


function test(ret_correct, cmd, ...)
    local arg = { ... }
    local b = ""
    local str = ""
    local ret = ""
    if arg[1] ~= nil then
        b = arg[1]
        str = "return "..cmd.."('"..b.."')"
    else
        str = "return "..cmd.."()"
    end
    
    local f = load(str)
    local ret_func = f()

    if ret_correct == ret_func then
        print("OK")
        count.oks = count.oks + 1
        return 1
    else
        print("ERROR: "..ret_correct.." != "..ret_func)
        count.errors = count.errors + 1
        return -1
    end

    print(ret);
end

function stopwatch(a)
    if a ~= nil then
        time[a] = os.clock()
    else
        time[a] = os.clock()
    end

    return time[2] - time[1]
end

-- version
test(tostring(call.version), "call:_version")

-- init
test("call.one:welcome=hello world", "call.one:welcome", "hello world")
test("call.one:undefined=hello world", "call.one:foo", "hello world")

test("call.two:welcome=hello world", "call.two:welcome", "hello world")
test("call.two:undefined=hello world", "call.two:foo", "hello world")

test("call.three:welcome=hello world", "call.three:welcome", "hello world")
test("call.three:undefined=hello world", "call.three:foo", "hello world")

test("call.three.abc:welcome=hello world", "call.three.abc:welcome", "hello world")
test("call.three.abc:undefined=hello world", "call.three.abc:foo", "hello world")

test("call.three:welcome", "call.three:welcome")
test("call.three.abc:undefined", "call.three.abc:foo")

-- reload
call:reload()

-- test again
test("call.one:welcome=hello world", "call.one:welcome", "hello world")
test("call.one:undefined=hello world", "call.one:foo", "hello world")

test("call.two:welcome=hello world", "call.two:welcome", "hello world")
test("call.two:undefined=hello world", "call.two:foo", "hello world")

test("call.three:welcome=hello world", "call.three:welcome", "hello world")
test("call.three:undefined=hello world", "call.three:foo", "hello world")

test("call.three.abc:welcome=hello world", "call.three.abc:welcome", "hello world")
test("call.three.abc:undefined=hello world", "call.three.abc:foo", "hello world")

test("call.three:welcome", "call.three:welcome")
test("call.three.abc:undefined", "call.three.abc:foo")

-- save value
test("call.two:savevalue=hello world", "call.two:savevalue", "hello world")
test("call.two:getvalue=hello world", "call.two:getvalue")

-- clean
call:reload()

-- test clean after reload
test("call.two:getvalue", "call.two:getvalue")


-- performance test
p = {}
stopwatch(1)
for i = 1,1000000,1 do
    call.two:welcome();
end
p.finish1 = stopwatch(2)
--print(string.format("elapsed time: %.4f", p.finish1))

foo_test = dofile(call.path.."/two.lua")
stopwatch(1)
for i = 1,1000000,1 do
    foo_test:welcome()
end
p.finish2 = stopwatch(2)
foo_test = nil
--print(string.format("elapsed time: %.4f", p.finish2))

p.pct = ( p.finish1 - p.finish2 ) / ( p.finish2/100 )
print("Slowed down by "..p.pct.." % [call.two:welcome()]")

-- performance test2
p = {}
stopwatch(1)
for i = 1,1000000,1 do
    call.three.abc:welcome();
end
p.finish1 = stopwatch(2)
--print(string.format("elapsed time: %.4f", p.finish1))

foo_test = dofile(call.path.."/three/abc.lua")
stopwatch(1)
for i = 1,1000000,1 do
    foo_test:welcome()
end
p.finish2 = stopwatch(2)
foo_test = nil
--print(string.format("elapsed time: %.4f", p.finish2))

p.pct = ( p.finish1 - p.finish2 ) / ( p.finish2/100 )
print("Slowed down by "..p.pct.." % [call.three.abc:welcome()]")

print()
print("Result OK="..count.oks.." ERRORS="..count.errors)
