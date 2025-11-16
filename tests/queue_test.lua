package.path = package.path .. ";../?.lua"
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
    local start_time1 = os.clock()
    local new_queue1 = Queue:new()
    for i = 1, 1000000 do
        new_queue1:enqueue(i)
    end
    local end_time1 = os.clock()
    local elapsed_time1 = end_time1 - start_time1
    print("Elapsed time: " .. elapsed_time1 .. " seconds")

    print("\nDequeue 1,000,000 items test:")
    local start_time2 = os.clock()
    for i = 1, 1000000 do
        new_queue1:dequeue(i)
    end
    local end_time2 = os.clock()
    local elapsed_time2 = end_time2 - start_time2
    print("Elapsed time: " .. elapsed_time2 .. " seconds")

    print("\nTotal time to enqueue and dequeue 1,000,000 items: "
            .. elapsed_time1 + elapsed_time2 .. " seconds")
end

if ... == nil then
    main()
end