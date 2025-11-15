package.path = package.path .. ";../?.lua"
local Queue = require("queue")  -- import Queue

function main()
    my_queue = Queue:new()
    for i = 1, 15 do
        my_queue:enqueue(i)
    end
    print(my_queue)
    while not my_queue:is_empty() do
        local removed = my_queue:dequeue()
        print("REMOVED: " .. removed)
        print("front=" .. my_queue._front, "rear=" .. my_queue._rear)
        for k, v in ipairs(my_queue._data) do
            print(k, v)
        end
        print()
    end
end

if ... == nil then
    main()
end