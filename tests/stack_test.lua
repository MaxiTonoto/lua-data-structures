-- Import same dir modules before changing package path
local Tests = require("tests")   -- common tests

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
    local new_stack = Stack:new()
    local push_million_items = Tests.time_test(
        function()
            for i = 1, 1000000 do
                new_stack:push(i)
            end
        end
    )
    print("Elapsed time: " .. push_million_items .. " seconds")
    print("\nPop 1,000,000 items test:")
    local pop_million_items = Tests.time_test(
        function()
            for i = 1, 1000000 do
                new_stack:pop()
            end
        end
    )
    print("Elapsed time: " .. pop_million_items .. " seconds")
    
    print("\nTotal time to push and pop 1,000,000 items: "
        .. push_million_items + pop_million_items .. " seconds")
end

-- this only executes if the current module was executed
if ... == nil then
    main()
end