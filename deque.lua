--[[
    Deque class.
Data structure that combines STACK and QUEUE.
Can add/remove items at the head/tail.
Uses a circular indexed table for items
and auxiliary variables for data such as size.
]]

local Deque = {}
local DEFAULT_CAPACITY = 10
Deque.__index = Deque

-- AUXILIARY EMPTY ELEMENT (can't use nil)
local EMPTY = {}
setmetatable(EMPTY, {
    __tostring = function() return "EMPTY" end
})

-- new function
function Deque:new()
    return Deque:init()
end

-- init function
function Deque:init()
    local obj = {}
    setmetatable(obj, Deque)

    obj._data = {}
    for i = 1, DEFAULT_CAPACITY do
        obj._data[i] = EMPTY
    end
    obj._head = 1
    obj._tail = 1
    obj._size = 0

    return obj
end

--[[
    #x method
Returns deque's number of items.
]]
function Deque:__len()
    return self._size
end

--[[
    x:size() method
Returns Deque's number of items.
]]
function Deque:size()
    return #self
end

--[[
    tostring(x) method
Returns Deque's string representation.
]]
function Deque:__tostring()
    if self:is_empty() then return "[]" end

    local items = {}
    local walk = self._head
    for i = 1, #self do
        items[#items+1] = tostring(self._data[walk])
        walk = (walk % #self._data) + 1 
    end

    return "[" .. table.concat(items, ", ") .. "]"
end

--[[
    x:is_empty() method
Returns a boolean, true if the deque is empty.
]]
function Deque:is_empty()
    return #self == 0
end

--[[
    x:_resize(amount) method
Helper method that sets the amout of EMPTY spaces available.
This does not increase x._size
It's O(n)
]]
function Deque:_resize(amount)
    local temp = {}
    local walk = self._head
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
    self._head = 1
    self._tail = self._size + 1   -- index of the next EMPTY space
end

--[[
    x:first() method
Returns the item at the head of the Deque.
Raises error if deque is empty.
]]
function Deque:first()
    if self:is_empty() then
        error("first() on empty queue", 2)
    end

    return self._data[self._head]
end

--[[
    x:last() method
Returns the item at the tail of the Deque.
Raises error if deque is empty.
]]
function Deque:last()
    if self:is_empty() then
        error("last() on empty queue", 2)
    end
    return self._data[((self._tail - 2) % #self._data) + 1]
end

--[[
    x:add_first(item) method
Adds an item to the head.
Raises error if item is nil.
]]
function Deque:add_first(item)
    if item == nil then
        error("add_first() recieved nil", 2)
    end
    
    -- double amount of space if full
    if self._size == #self._data then 
        self:_resize(#self._data * 2)
    end

    self._head = ((self._head - 2) % #self._data) + 1
    self._data[self._head] = item
    self._size = self._size + 1
end

--[[
    x:add_last(item) method
Adds an item to the tail.
Raises error if item is nil.
]]
function Deque:add_last(item)
    if item == nil then
        error("add_first() recieved nil", 2)
    end
    
    -- double amount of space if full
    if self._size == #self._data then 
        self:_resize(#self._data * 2)
    end

    self._data[self._tail] = item
    self._tail = (self._tail % #self._data) + 1
    self._size = self._size + 1
end

--[[
    x:delete_first() method
Returns and removes the "left-most" element.
Raises error if deque is empty.
]]
function Deque:delete_first()
    if self:is_empty() then
        error("delete_first() on empty deque", 2)
    end

    local item = self._data[self._head]
    self._data[self._head] = EMPTY
    self._head = (self._head % #self._data) + 1

    self._size = self._size - 1
    
    return item
end

--[[
    x:delete_last() method
Returns and removes the "right-most" element.
Raises error if deque is empty.
]]
function Deque:delete_last()
    if self:is_empty() then
        error("delete_last() on empty deque", 2)
    end

    local item = self._data[((self._tail - 2) % #self._data) + 1]
    self._data[((self._tail - 2) % #self._data) + 1] = EMPTY
    self._tail = ((self._tail - 2) % #self._data) + 1

    self._size = self._size - 1
    
    return item
end

--[[
    x:clear() method
Clears all items on the deque.
]]
function Deque:clear()
    self._data = {}
    for i = 1, DEFAULT_CAPACITY do
        self._data[i] = EMPTY
    end
    self._head = 1
    self._tail = 1
    self._size = 0
end

return Deque