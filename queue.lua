--[[
    Queue class.
Data structure that follows the FIFO policy.
Uses a circular indexed table for items
and auxiliary variables for data such as size.
]]

local Queue = {}
local DEFAULT_CAPACITY = 10
Queue.__index = Queue

-- AUXILIARY EMPTY ELEMENT (can't use nil)
local EMPTY = {}
setmetatable(EMPTY, {
    __tostring = function() return "EMPTY" end
})

-- new function
function Queue:new()
    return Queue:init()
end

-- init function
function Queue:init()
    local obj = {}
    setmetatable(obj, Queue)

    obj._data = {}
    for i = 1, DEFAULT_CAPACITY do
        obj._data[i] = EMPTY
    end
    obj._front = 1
    obj._rear = 1
    obj._size = 0

    return obj
end

--[[
    #x method
Returns queue's number of items.
]]
function Queue:__len()
    return self._size
end

--[[
    x:size() method
Returns queue's number of items.
]]
function Queue:size()
    return #self
end

--[[
    tostring(x) method
Returns queue's string representation.
]]
function Queue:__tostring()
    if self:is_empty() then return "[]" end

    local items = {}   -- Get all items on a single table
    local walk = self._front
    for i = 1, #self do
        items[#items+1] = tostring(self._data[walk])
        walk = (walk % #self._data) + 1 
    end

    return "[" .. table.concat(items, ", ") .. "]"
end

--[[
    x:_resize(amount) method
Helper method that sets the amout of EMPTY spaces available.
This does not increase x._size
It's O(n)
]]
function Queue:_resize(amount)
    local temp = {}
    local walk = self._front
    for i = 1, amount do
        -- copy old data's items starting from index 1
        if i <= self._size then
            temp[#temp+1] = self._data[walk]
            walk = (walk % #self._data) + 1
        else
            temp[i] = EMPTY
        end
    end
    self._data = temp
    self._front = 1
    self._rear = self._size + 1   -- index of the next EMPTY space
end

--[[
    x:is_empty() method
Returns a boolean, true if the queue is empty.
]]
function Queue:is_empty()
    return #self == 0
end

--[[
    x:first() method
Returns queue's oldest element without removing it.
Raises error if the queue is empty.
]]
function Queue:first()
    if self:is_empty() then
        error("first() on empty queue", 2)
    end
    
    return self._data[self._front]
end

--[[
    x:front() method
Returns queue's oldest element without removing it.
Raises error if the queue is empty.
]]
function Queue:front()
    if self:is_empty() then
        error("front() on empty queue", 2)
    end

    return self:first()
end

--[[
    x:enqueue(item) method
Enqueues an item.
Raises error if item is nil.
]]
function Queue:enqueue(item)
    if item == nil then
        error("enqueue() recieved nil", 2)
    end
    
    -- double amount of space if full
    if self._size == #self._data then 
        self:_resize(#self._data * 2)
    end

    self._data[self._rear] = item
    self._rear = (self._rear % #self._data) + 1 
    self._size = self._size + 1
end

--[[
    x:dequeue() method
Returns and removes the oldest item enqueued.
Raises error if queue is empty.
]]
function Queue:dequeue()
    if self:is_empty() then
        error("dequeue() on empty queue", 2)
    end
    
    -- halve the amount of space if there are too many EMPTY spaces
    if #self._data >= (self._size * 8) then 
        self:_resize(#self._data // 2)
    end

    local item = self._data[self._front]   -- save for later
    self._data[self._front] = EMPTY
    self._front = (self._front % #self._data) + 1
    self._size = self._size - 1

    return item   -- this is later
end

--[[
    x:clear() method
Clears all items on the queue.
]]
function Queue:clear()
    self._data = {}
    for i = 1, DEFAULT_CAPACITY do
        self._data[i] = EMPTY
    end
    self._front = 1
    self._rear = 1
    self._size = 0
end

return Queue