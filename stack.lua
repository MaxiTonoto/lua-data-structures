
local Stack = {}
Stack.__index = Stack

function Stack:init(default_items)
    local obj = {}
    setmetatable(obj, Stack)

    obj._data = default_items or {}

    return obj
end

function Stack:__tostring()
    local items = {}
    for _, v in ipairs(self._data) do
        items[#items+1] = tostring(v)
    end

    items = table.concat(items, ", ")
    return "Stack[" .. items .. "]"
end

function Stack:__len()
    return #self._data
end

function Stack:is_empty()
    return #self == 0
end

function Stack:top()
    if self:is_empty() then
        error("top() on empty stack", 2)
        return
    end

    return self._data[#self._data]
end

function Stack:peek()
    return self:top()
end

function Stack:pop()
    if self:is_empty() then
        error("pop() on empty stack", 2)
        return
    end

    local latest_element = self._data[#self._data]
    self._data[#self._data] = nil
    return latest_element
end

function Stack:push(element)
    if not element then
        error("push() parameter missing or nil", 2)
        return
    end

    self._data[#self._data+1] = element
end

