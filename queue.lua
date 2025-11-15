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
Queue.EMPTY = {}

-- new function
function Queue:new(default_items)
    return Queue:init(default_items)
end

-- init function
function Queue:init(default_items)
    local obj = {}
    setmetatable(obj, Queue)

    -- allows no params
    obj._data = default_items or {}
    obj._front = 1
    obj._rear = #default_items or 1
    obj._size = #default_items or 0

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

    self._data[self._rear] = item
    self._size = self._size + 1
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

    self._data[self._rear] = item
    self._size = self._size - 1
end

