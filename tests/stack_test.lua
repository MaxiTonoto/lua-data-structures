package.path = package.path .. ";../?.lua"
local Stack = require("stack")  -- import Stack

function main()
    my_stack = Stack:new()
    print("Created stack: my_stack")
    print("Pushing numbers 1 to 5")
    for i = 1, 5 do
        my_stack:push(i)    
        print("#my_stack=" .. #my_stack, my_stack)
    end
    print("my_stack:peek()=" .. my_stack:peek())
    print("my_stack:top()=" .. my_stack:top())
    print("my_stack:pop()=" .. my_stack:pop())
    print("my_stack:pop()=" .. my_stack:pop())
    print("tostring(my_stack)=" .. tostring(my_stack))
    print("my_stack:is_empty()=" .. tostring(my_stack:is_empty()))
    print("my_stack:clear()")
    my_stack:clear()
    print("tostring(my_stack)=" .. tostring(my_stack))
    print("my_stack:is_empty()=" .. tostring(my_stack:is_empty()))

    print("\nPush 1,000,000 items test:")
    local start_time1 = os.clock()
    local new_stack = Stack:new()
    for i = 1, 1000000 do
        new_stack:push(i)
    end
    local end_time1 = os.clock()
    local elapsed_time1 = end_time1 - start_time1
    print("Elapsed time: " .. elapsed_time1 .. " seconds")

    print("\nPop 1,000,000 items test:")
    local start_time2 = os.clock()
    for i = 1, 1000000 do
        new_stack:pop()
    end
    local end_time2 = os.clock()
    local elapsed_time2 = end_time2 - start_time2
    print("Elapsed time: " .. elapsed_time2 .. " seconds")

    print("\nTotal time to push and pop 1,000,000 items: "
            .. elapsed_time1 + elapsed_time2 .. " seconds")
end

-- this only executes if the current module was executed
if ... == nil then
    main()
end