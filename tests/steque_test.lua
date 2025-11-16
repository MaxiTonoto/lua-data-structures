local Tests = require("tests")   -- common tests
package.path = package.path .. ";../?.lua;"
local Steque = require("steque")  -- import Steque

function main()
    local my_steque = Steque:new()
    print("Created steque: my_steque")
    print("my_steque:is_empty()=" .. tostring(my_steque:is_empty()))
    print("String representation:" .. tostring(my_steque))
    print("\nPush: 1 to 5")
    for i = 1, 5 do
        my_steque:push(i)
    end
    print("my_steque=" .. tostring(my_steque))
    print("#my_steque=" .. tostring(#my_steque))
    print("my_steque:is_empty()=" .. tostring(my_steque:is_empty()))
    print("\nEnqueue: 'a' to 'e'")
    for i = 97, 97+4 do
        my_steque:enqueue(string.char(i))
    end
    print("my_steque=" .. tostring(my_steque))

    print("\nPop: 5 times")
    for i = 1, 5 do
        print("DELETED: " .. tostring(my_steque:pop(i)))
    end
    print("my_steque=" .. tostring(my_steque))

    print("\nEnqueue 500,000 items test")
    local new_steque = Steque:new()
    local enqueue_500k_items = Tests.time_test(
        function()
           for i = 1, 500000 do
                new_steque:enqueue(i)
            end 
        end
    )
    print("Elapsed time: " .. enqueue_500k_items .. " seconds")

    print("\nPush 500,000 items test")
    local push_500k_items = Tests.time_test(
        function()
           for i = 1, 500000 do
                new_steque:push(i)
            end 
        end
    )
    print("Elapsed time: " .. push_500k_items .. " seconds")

    print("\nPop 1,000,000 items test")
    local pop_million_items = Tests.time_test(
        function()
           for i = 1, 1000000 do
                new_steque:pop(i)
            end 
        end
    )
    print("Elapsed time: " .. pop_million_items .. " seconds")

    print("\nTotal time to add 1,000,000 items: " .. 
        enqueue_500k_items + push_500k_items
        .. " seconds"
    )

    print("Total time: "
        .. enqueue_500k_items
        + push_500k_items
        + pop_million_items
        .. " seconds"
    )
end

if ... == nil then
    main()
end