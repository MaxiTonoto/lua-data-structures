--[[
    MultiwayTreeNode class
Node for MultiwayTree. Has a reference to its tree
and a table for children.
]]
local MultiwayTreeNode = {}
MultiwayTreeNode.__index = MultiwayTreeNode
local children_mt = {
    __tostring = function(children)
        local items = {}
        for i = 1, #children do
            items[#items+1] = tostring(children[i])
        end
        return "[" .. table.concat(items, ", ") .. "]"
    end
}

-- new function
function MultiwayTreeNode:new(item)
    return MultiwayTreeNode:init(item)
end

-- init function
function MultiwayTreeNode:init(item)
    local obj = {}
    setmetatable(obj, MultiwayTreeNode)

    obj._tree = nil
    obj._item = item
    obj._parent = nil
    obj._children = {}
    setmetatable(obj._children, children_mt)

    return obj
end

--[[
    tostring(x) method
Represents a Multiway Tree Node as a string
]]
function MultiwayTreeNode:__tostring()
    return tostring(self._item)
end

--[[
    x:children() method
Returns a table of current node's children
]]
function MultiwayTreeNode:children()
    return self._children
end

--[[
    total_children() method
Gets total amount of children that this
node and its children have using recursion
]]
function MultiwayTreeNode:total_children()
    local count = 0

    for i = 1, #self._children do
        local child = self._children[i]
        count = count + 1
        count = count + self.total_children(child)
    end

    return count
end

return MultiwayTreeNode