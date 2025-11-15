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
    tostring(x) method
Returns queue's number of items.
]]
function Queue:__tostring()
    if self:is_empty() then return "[]" end

    items = {}
    walk = self._front
    for i = 1, #self do
        items[#items+1] = self._data[walk]
        walk = (walk + 1) % #self._data
    end

    return "[" .. table.concat(items, ", ") .. "]"
end


--[[
    x:is_empty() method
Returns a boolean if the queue is empty.
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
    if self.is_empty() then
        error("pop() on empty stack", 2)
    end
    
    return self._data[self._front]
end

--[[
    x:front() method
Returns queue's oldest element without removing it.
Raises error if the queue is empty.
]]
function Queue:front()
    return self:first()
end

--[[
    x:enqueue(item) method
Enqueues an item in the queue.
Raises error if item is nil or false.
]]
function Queue:enqueue(item)
    if not item then
        error("enqueue() parameter missing or nil", 2)
    end
    self._size = self._size + 1
    self._data[self._rear] = item
    self._rear = (self._rear + 1) % #self._data
end

--[[
    x:dequeue() method
Returns the oldest item enqueued.
Raises error if queue is empty.
]]
function Queue:dequeue()
    if self:is_empty() then
        error("dequeue() on empty queue", 2)
    end
    self._size = self._size - 1
    item = self._data[self._front]   -- save for later
    self._data[self._front] = EMPTY
    self._front = (self._front + 1) % #self._data

    return item   -- this is later
end

return Queue