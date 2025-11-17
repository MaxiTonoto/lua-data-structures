--[[
    Steque class.
Data structure that combines STACK and QUEUE.
Can push, pop and enqueue, but not dequeue,
Uses a circular indexed table for items
and auxiliary variables for data such as size.
]]

local Steque = {}
local DEFAULT_CAPACITY = 10
Steque.__index = Steque

-- AUXILIARY EMPTY ELEMENT (can't use nil)
local EMPTY = {}
setmetatable(EMPTY, {
    __tostring = function() return "EMPTY" end
})

-- new function
function Steque:new()
    return Steque:init()
end

-- init function
function Steque:init()
    local obj = {}
    setmetatable(obj, Steque)

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
Returns steque's number of items.
]]
function Steque:__len()
    return self._size
end

--[[
    x:size() method
Returns Steque's number of items.
]]
function Steque:size()
    return #self
end

--[[
    tostring(x) method
Returns steque's string representation.
]]
function Steque:__tostring()
    if self:is_empty() then return "[]" end

    local items = {}
    local walk = self._head
    for _ = 1, #self do
        items[#items+1] = tostring(self._data[walk])
        walk = (walk % #self._data) + 1 
    end

    return "[" .. table.concat(items, ", ") .. "]"
end

--[[
    x:is_empty() method
Returns a boolean, true if the steque is empty.
]]
function Steque:is_empty()
    return #self == 0
end

--[[
    x:_resize(amount) method
Helper method that sets the amout of EMPTY spaces available.
This does not increase x._size
It's O(n)
]]
function Steque:_resize(amount)
    local temp = {}
    local walk = self._head
    for i = 1, amount do
        if i <= self._size then
            temp[#temp+1] = self._data[walk]
            walk = (walk % #self._data) + 1
        else
            temp[i] = EMPTY
        end
    end
    self._data = temp
    self._head = 1
    self._tail = self._size + 1
end

--[[
    x:peek() method
Returns the item at the tail of the steque
without removing it.
Raises error if steque is empty.
]]
function Steque:peek()
    if self:is_empty() then
        error("peek() on empty steque", 2)
    end
    return self._data[((self._tail - 2) % #self._data) + 1]
end

--[[
    x:enqueue(item) method
Enqueues an item to the head.
Raises error if item is nil.
]]
function Steque:enqueue(item)
    if item == nil then
        error("enqueue() recieved nil", 2)
    end
    
    if self._size == #self._data then 
        self:_resize(#self._data * 2)
    end

    self._head = ((self._head - 2) % #self._data) + 1
    self._data[self._head] = item
    self._size = self._size + 1
end

--[[
    x:push(item) method
Pushes an item to the tail.
Raises error if item is nil.
]]
function Steque:push(item)
    if item == nil then
        error("push() recieved nil", 2)
    end
    
    if self._size == #self._data then 
        self:_resize(#self._data * 2)
    end

    self._data[self._tail] = item
    self._tail = (self._tail % #self._data) + 1
    self._size = self._size + 1
end

--[[
    x:pop() method
Returns and removes the "right-most" element.
Raises error if steque is empty.
]]
function Steque:pop()
    if self:is_empty() then
        error("pop() on empty steque", 2)
    end

    if #self._data >= (self._size * 8) then 
        self:_resize(math.floor(#self._data / 2))
    end

    local item = self._data[((self._tail - 2) % #self._data) + 1]
    self._data[((self._tail - 2) % #self._data) + 1] = EMPTY
    self._tail = ((self._tail - 2) % #self._data) + 1

    self._size = self._size - 1
    
    return item
end

--[[
    x:clear() method
Clears all items on the steque.
]]
function Steque:clear()
    self._data = {}
    for i = 1, DEFAULT_CAPACITY do
        self._data[i] = EMPTY
    end
    self._head = 1
    self._tail = 1
    self._size = 0
end

return Steque