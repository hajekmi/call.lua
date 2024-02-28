
call = dofile("../src/call.lua")
call:path('./modules/');
call:reload()

debug = 0
count = {
    errors = 0,
    oks = 0,
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

call:reload()

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


test("call.two:savevalue=hello world", "call.two:savevalue", "hello world")
test("call.two:getvalue=hello world", "call.two:getvalue")

call:reload()

test("call.two:getvalue", "call.two:getvalue")



--call.two:get()

print("Result OK="..count.oks.." ERRORS="..count.errors)
