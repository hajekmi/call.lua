
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

-- dir: ./
test("call.a:welcome=hello world 1", "call.a:welcome", "hello world 1")
test("call.a:undefined=hello world 1", "call.a:foo", "hello world 1")

test("call.b:welcome=hello world 2", "call.b:welcome", "hello world 2")
test("call.b:undefined=hello world 2", "call.b:foo", "hello world 2")

test("call.c:welcome=hello world 3", "call.c:welcome", "hello world 3")
test("call.c:undefined=hello world 3", "call.c:foo", "hello world 3")

-- dir: ./a/
test("call.a.aa:welcome=hello world 4", "call.a.aa:welcome", "hello world 4")
test("call.a.aa:undefined=hello world 4", "call.a.aa:foo", "hello world 4")

test("call.a.ab:welcome=hello world 5", "call.a.ab:welcome", "hello world 5")
test("call.a.ab:undefined=hello world 5", "call.a.ab:foo", "hello world 5")

test("call.a.ac:welcome=hello world 6", "call.a.ac:welcome", "hello world 6")
test("call.a.ac:undefined=hello world 6", "call.a.ac:foo", "hello world 6")

-- dir: ./a/aa/
test("call.a.aa.aaa:welcome=hello world 7", "call.a.aa.aaa:welcome", "hello world 7")
test("call.a.aa.aaa:undefined=hello world 7", "call.a.aa.aaa:foo", "hello world 7")

test("call.a.aa.aab:welcome=hello world 8", "call.a.aa.aab:welcome", "hello world 8")
test("call.a.aa.aab:undefined=hello world 8", "call.a.aa.aab:foo", "hello world 8")

test("call.a.aa.aac:welcome=hello world 9", "call.a.aa.aac:welcome", "hello world 9")
test("call.a.aa.aac:undefined=hello world 9", "call.a.aa.aac:foo", "hello world 9")

-- dir: ./a/ab/
test("call.a.ab.aba:welcome=hello world 7", "call.a.ab.aba:welcome", "hello world 7")
test("call.a.ab.aba:undefined=hello world 7", "call.a.ab.aba:foo", "hello world 7")

test("call.a.ab.abb:welcome=hello world 8", "call.a.ab.abb:welcome", "hello world 8")
test("call.a.ab.abb:undefined=hello world 8", "call.a.ab.abb:foo", "hello world 8")

test("call.a.ab.abc:welcome=hello world 9", "call.a.ab.abc:welcome", "hello world 9")
test("call.a.ab.abc:undefined=hello world 9", "call.a.ab.abc:foo", "hello world 9")

-- dir: ./b/
test("call.b.ba:welcome=hello world 10", "call.b.ba:welcome", "hello world 10")
test("call.b.ba:undefined=hello world 10", "call.b.ba:foo", "hello world 10")

test("call.b.bb:welcome=hello world 11", "call.b.bb:welcome", "hello world 11")
test("call.b.bb:undefined=hello world 11", "call.b.bb:foo", "hello world 11")

test("call.b.bc:welcome=hello world 12", "call.b.bc:welcome", "hello world 12")
test("call.b.bc:undefined=hello world 12", "call.b.bc:foo", "hello world 12")

-- dir: ./b/ba/
test("call.b.ba.baa:welcome=hello world 13", "call.b.ba.baa:welcome", "hello world 13")
test("call.b.ba.baa:undefined=hello world 13", "call.b.ba.baa:foo", "hello world 13")

test("call.b.ba.bab:welcome=hello world 14", "call.b.ba.bab:welcome", "hello world 14")
test("call.b.ba.bab:undefined=hello world 14", "call.b.ba.bab:foo", "hello world 14")

test("call.b.ba.bac:welcome=hello world 15", "call.b.ba.bac:welcome", "hello world 15")
test("call.b.ba.bac:undefined=hello world 15", "call.b.ba.bac:foo", "hello world 15")

-- save value
test("call.a.aa:savevalue=hello world", "call.a.aa:savevalue", "hello world")
test("call.a.aa:getvalue=hello world", "call.a.aa:getvalue")

-- reload
call:reload()

-- test clean after reload
test("call.a.aa:getvalue", "call.a.aa:getvalue")

-- again test
-- dir: ./
test("call.a:welcome=hello world 1", "call.a:welcome", "hello world 1")
test("call.a:undefined=hello world 1", "call.a:foo", "hello world 1")

test("call.b:welcome=hello world 2", "call.b:welcome", "hello world 2")
test("call.b:undefined=hello world 2", "call.b:foo", "hello world 2")

test("call.c:welcome=hello world 3", "call.c:welcome", "hello world 3")
test("call.c:undefined=hello world 3", "call.c:foo", "hello world 3")

-- dir: ./a/
test("call.a.aa:welcome=hello world 4", "call.a.aa:welcome", "hello world 4")
test("call.a.aa:undefined=hello world 4", "call.a.aa:foo", "hello world 4")

test("call.a.ab:welcome=hello world 5", "call.a.ab:welcome", "hello world 5")
test("call.a.ab:undefined=hello world 5", "call.a.ab:foo", "hello world 5")

test("call.a.ac:welcome=hello world 6", "call.a.ac:welcome", "hello world 6")
test("call.a.ac:undefined=hello world 6", "call.a.ac:foo", "hello world 6")

-- dir: ./a/aa/
test("call.a.aa.aaa:welcome=hello world 7", "call.a.aa.aaa:welcome", "hello world 7")
test("call.a.aa.aaa:undefined=hello world 7", "call.a.aa.aaa:foo", "hello world 7")

test("call.a.aa.aab:welcome=hello world 8", "call.a.aa.aab:welcome", "hello world 8")
test("call.a.aa.aab:undefined=hello world 8", "call.a.aa.aab:foo", "hello world 8")

test("call.a.aa.aac:welcome=hello world 9", "call.a.aa.aac:welcome", "hello world 9")
test("call.a.aa.aac:undefined=hello world 9", "call.a.aa.aac:foo", "hello world 9")

-- dir: ./a/ab/
test("call.a.ab.aba:welcome=hello world 7", "call.a.ab.aba:welcome", "hello world 7")
test("call.a.ab.aba:undefined=hello world 7", "call.a.ab.aba:foo", "hello world 7")

test("call.a.ab.abb:welcome=hello world 8", "call.a.ab.abb:welcome", "hello world 8")
test("call.a.ab.abb:undefined=hello world 8", "call.a.ab.abb:foo", "hello world 8")

test("call.a.ab.abc:welcome=hello world 9", "call.a.ab.abc:welcome", "hello world 9")
test("call.a.ab.abc:undefined=hello world 9", "call.a.ab.abc:foo", "hello world 9")

-- dir: ./b/
test("call.b.ba:welcome=hello world 10", "call.b.ba:welcome", "hello world 10")
test("call.b.ba:undefined=hello world 10", "call.b.ba:foo", "hello world 10")

test("call.b.bb:welcome=hello world 11", "call.b.bb:welcome", "hello world 11")
test("call.b.bb:undefined=hello world 11", "call.b.bb:foo", "hello world 11")

test("call.b.bc:welcome=hello world 12", "call.b.bc:welcome", "hello world 12")
test("call.b.bc:undefined=hello world 12", "call.b.bc:foo", "hello world 12")

-- dir: ./b/ba/
test("call.b.ba.baa:welcome=hello world 13", "call.b.ba.baa:welcome", "hello world 13")
test("call.b.ba.baa:undefined=hello world 13", "call.b.ba.baa:foo", "hello world 13")

test("call.b.ba.bab:welcome=hello world 14", "call.b.ba.bab:welcome", "hello world 14")
test("call.b.ba.bab:undefined=hello world 14", "call.b.ba.bab:foo", "hello world 14")

test("call.b.ba.bac:welcome=hello world 15", "call.b.ba.bac:welcome", "hello world 15")
test("call.b.ba.bac:undefined=hello world 15", "call.b.ba.bac:foo", "hello world 15")

-- save value
test("call.a.aa:savevalue=hello world", "call.a.aa:savevalue", "hello world")
test("call.a.aa:getvalue=hello world", "call.a.aa:getvalue")




-- performance test
p = {}
stopwatch(1)
for i = 1,1000000,1 do
    call.a:welcome();
end
p.finish1 = stopwatch(2)
--print(string.format("elapsed time: %.4f", p.finish1))

foo_test = dofile(call.path.."/a.lua")
stopwatch(1)
for i = 1,1000000,1 do
    foo_test:welcome()
end
p.finish2 = stopwatch(2)
foo_test = nil
--print(string.format("elapsed time: %.4f", p.finish2))

p.pct = ( p.finish1 - p.finish2 ) / ( p.finish2/100 )
print("Slowed down by "..p.pct.." % [call.a:welcome()]")

-- performance test2
p = {}
stopwatch(1)
for i = 1,1000000,1 do
    call.a.aa.aab:welcome();
end
p.finish1 = stopwatch(2)
--print(string.format("elapsed time: %.4f", p.finish1))

foo_test = dofile(call.path.."/a/aa/aab.lua")
stopwatch(1)
for i = 1,1000000,1 do
    foo_test:welcome()
end
p.finish2 = stopwatch(2)
foo_test = nil
--print(string.format("elapsed time: %.4f", p.finish2))

p.pct = ( p.finish1 - p.finish2 ) / ( p.finish2/100 )
print("Slowed down by "..p.pct.." % [call.a.aa.aab:welcome()]")

print()
print("Result OK="..count.oks.." ERRORS="..count.errors)



