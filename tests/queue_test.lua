-- Import same dir modules before changing package path
local Tests = require("tests")   -- common tests

package.path = package.path .. ";../?.lua;"
local Queue = require("queue")  -- import Queue


function main()
    my_queue = Queue:new()
    print("Created queue: my_queue")
    print("\nQueue numbers 1 to 5:")
    for i = 1, 5 do
        my_queue:enqueue(i)
        print("my_queue=" .. tostring(my_queue))
    end
    print("#my_queue=" .. #my_queue)
    print("my_queue:first()=" .. my_queue:first())
    print("Dequeue 3 times")
    for i = 1, 3 do
        print("my_queue:dequeue()=" .. my_queue:dequeue())
    end
    print("my_queue=" .. tostring(my_queue))
    print("#my_queue=" .. #my_queue)
    print("\nQueue 1 and 2 again:")
    my_queue:enqueue(1)
    my_queue:enqueue(2)
    print("my_queue=" .. tostring(my_queue))
    print("#my_queue=" .. #my_queue)
    print("\nDequeue 2 times:")
    print("my_queue:dequeue()=" .. my_queue:dequeue())
    print("my_queue:dequeue()=" .. my_queue:dequeue())
    print("my_queue=" .. tostring(my_queue))
    print("#my_queue=" .. #my_queue)

    print("\nQueue 1,000,000 items test:")
    local new_queue = Queue:new()
    enqueue_million_items = Tests.time_test(
        function()
           for i = 1, 1000000 do
                new_queue:enqueue(i)
            end 
        end
    )
    print("Elapsed time: " .. enqueue_million_items .. " seconds")

    print("\nDequeue 1,000,000 items test:")
    dequeue_million_items = Tests.time_test(
        function()
            for i = 1, 1000000 do
                new_queue:dequeue(i)
            end
        end
    )
    print("Elapsed time: " .. dequeue_million_items .. " seconds")

    print("\nTotal time to enqueue & dequeue 1,000,000 items: "
        .. enqueue_million_items
        + dequeue_million_items .. " seconds")
end

if ... == nil then
    main()
end