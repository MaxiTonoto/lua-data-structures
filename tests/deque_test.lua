local Tests = require("tests")   -- common tests
package.path = package.path .. ";../?.lua;"
local Deque = require("deque")  -- import Deque

function main()
    local my_deque = Deque:new()

    for i = 1, 11 do
        my_deque:add_last(i)
    end
    for k, v in ipairs(my_deque._data) do
        print(k, v)
    end
    print(); print(); print();
    for i = 1, 11 do
        my_deque:add_first(i)
    end
    for k, v in ipairs(my_deque._data) do
        print(k, v)
    end
end

if ... == nil then
    main()
end