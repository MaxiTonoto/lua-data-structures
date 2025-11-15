package.path = package.path .. ";../?.lua"
local Stack = require("stack")  -- import Stack

function main()
    my_stack = Stack:init()
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
    print("my_stack=" .. tostring(my_stack))
    print("my_stack:is_empty()=" .. tostring(my_stack:is_empty()))
end

-- this only executes if the current module was executed
if ... == nil then
    main()
end