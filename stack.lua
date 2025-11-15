--[[
    Stack class.
Data structure that follows the LIFO policy.
Uses an indexed table for items.
]]

local Stack = {}
Stack.__index = Stack

-- new method
function Stack:new(default_items)
    return Stack:init(default_items)
end

-- init method
function Stack:init(default_items)
    local obj = {}
    setmetatable(obj, Stack)

    -- allows no params
    obj._data = default_items or {}

    return obj
end

--[[
    tostring(x) method
Returns all stack's items as strings.
]]
function Stack:__tostring()
    -- empty stack
    if self:is_empty() then return "[]" end
    
    local items = {}
    for i = 1, #self._data do
        items[#items+1] = tostring(self._data[i])
    end

    return "[" .. table.concat(items, ", ") .. "]"
end

--[[
    #x method
Returns stack's number of items.
]]
function Stack:__len()
    return #self._data
end

--[[
    x:is_empty() method
Returns a boolean if the stack is empty.
]]
function Stack:is_empty()
    return #self == 0
end

--[[
    x:top() method
Returns stack's top item without removing it. 
Raises error if the stack is empty.
]]
function Stack:top()
    if self:is_empty() then
        error("top() on empty stack", 2)
    end

    return self._data[#self._data]
end

--[[
    x:peek() method
Returns stack's top item without removing it. 
Raises error if the stack is empty.
]]
function Stack:peek()
    return self:top()
end

--[[
    x:pop() method
Removes the last item pushed onto the stack.
Raises error if the stack is empty.
]]
function Stack:pop()
    if self:is_empty() then
        error("pop() on empty stack", 2)
    end

    local latest_element = self._data[#self._data]
    self._data[#self._data] = nil
    return latest_element
end

--[[
    x:push(element) method
Pushes an item onto the stack.
Recieves parameter "element" with the item to push.
Raises error if no "element" is given.
]]
function Stack:push(element)
    if not element then
        error("push() parameter missing or nil", 2)
    end

    self._data[#self._data+1] = element
end

--[[
    x:clear() method
Clears all items on the stack.
]]
function Stack:clear()
    for i = 1, #self._data do
        self._data[i] = nil
    end
end

return Stack