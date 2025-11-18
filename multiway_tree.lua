local MultiwayTreeNode = require("multiway_tree_node")
local Queue = require("queue")

--[[
    MultiwayTree class
Multiway tree that recieves a
parameter n: number that defines
the amount of children each of its
nodes can have. If not given, there
is no limit.
]]
local MultiwayTree = {}
MultiwayTree.__index = MultiwayTree

-- new function
function MultiwayTree:new(n)
    return MultiwayTree:init(n)
end

-- init function
function MultiwayTree:init(n)
    local obj = {}
    setmetatable(obj, MultiwayTree)

    obj._root = nil
    obj._size = 0
    obj._n = n or nil

    return obj
end

function MultiwayTree:BFS()
    local items = {}
    local queue = Queue:new()

    queue:enqueue(self._root)
    while not queue:is_empty() do
        local current = queue:dequeue()
        table.insert(items, current)
        for i = 1, #current:children() do
            queue:enqueue(current._children[i])
        end
    end

    return items
end

--[[
    tostring(x) method
Represents the multiway tree as a string
]]
function MultiwayTree:__tostring()
    local items = self:BFS()
    for i = 1, #items do
        items[i] = tostring(items[i])
    end
    return "MultiwayTree[" .. table.concat(items, ", ") .. "]"
end

--[[
    #x method
Returns multiway tree's number of items.
]]
function MultiwayTree:__len()
    return self._size
end

--[[
    x:size() method
Returns multiway tree's number of items.
]]
function MultiwayTree:size()
    return #self
end

--[[
    x:is_empty() method
Returns a boolean, true if the multiway tree is empty.
]]
function MultiwayTree:is_empty()
    return #self == 0
end

--[[
    x:root() method
Returns the root node's item
]]
function MultiwayTree:root()
    return self._root._item
end

--[[
    x:order() method
Returns the max amount of children
that a node can have
]]
function MultiwayTree:order()
    return self._n
end

--[[
    x:parent(node) method
Returns the parent of a given node
]]
function MultiwayTree:parent(node)
    return node._parent
end

--[[
    x:children(node) method
Returns the indexed table of the given node
]]
function MultiwayTree:children(node)
    return node._children   
end

--[[
    x:info(node) method
Returns given node's value
]]
function MultiwayTree:info(node)
    return node._item
end

--[[
    x:contains(node) method
Returns a boolean, true if the current tree
contains the given node
]]
function MultiwayTree:contains(node)
    if node._tree == self then
        return true
    else
        return false
    end
end

--[[
    x:is_leaf(node)
Returns a boolean, true if given 
node is a leaf (has no children)
]]
function MultiwayTree:is_leaf(node)
    return #node:children() == 0
end

--[[
    x:create_node(item) method
Creates a multiway tree node with a given item.
Recieves parameter item.
Raises error if parameter is nil
Returns MultiwayTreeNode
]]
function MultiwayTree:create_node(item)
    if item == nil then
        error("add_root() recieved nil parameter", 2)
    end

    return MultiwayTreeNode:init(item)
end

--[[
    x:add_root(node) method
Adds a MultiwayTreeNode as the root.
Recieves a parameter node. It is assumed it's
already got the item (useful information) in it. 
]]
function MultiwayTree:add_root(node)
    if self._root ~= nil then
        error("add_root() in tree with pre-existing root", 2)
    end

    self._root = node
    self._root._tree = self
    self._size = self._size + 1
end

--[[
    x:add_child(parent_node, node) method
Given a parent_node, adds the given node to
its table of children.
Raises error if:
    parent_node is not part of the tree
    parent_node has max amount of children
    node is already contained in current tree
]]
function MultiwayTree:add_child(parent_node, node)
    if not self:contains(parent_node) then
        error("add_child() given parent_node not in tree", 2)
    end
    if self:contains(node) then
        error("add_child() given node already in tree", 2)
    end
    if self._n then
        if #parent_node._children >= self._n then
            error("add_child() parent_node has max amount of children (" .. self._n .. ")", 2)
        end
    end

    node._tree = self
    node._parent = parent_node
    parent_node._children[#parent_node._children+1] = node
    self._size = self._size + 1
end

--[[
    x:remove_child(parent_node, node, promote_children) method
Given a parent_node, removes the given node from its table of children.
Recieves parameter
    promote_children: boolean
        true = parent_node recieves as many children from the
               removed node as it can contain
        false/default = the entire subtree is removed
Raises error if:
    parent_node is not part of the tree
    node is not found as a child of parent_node
]]
function MultiwayTree:remove_child(parent_node, node, promote_children)
    promote_children = promote_children == true  -- default value

    if not self:contains(parent_node) then
        error("remove_child() given parent_node not in tree", 2)
    end

    -- search and remove the node from the parent
    local found = false
    local removed_child_index
    for i = 1, #parent_node._children do
        if parent_node._children[i] == node then
            table.remove(parent_node._children, i)
            found = true
            removed_child_index = i
            break
        end
    end
    if not found then
        error("remove_child() child node not found in parent", 2)
    end

    -- update node properties
    node._tree = nil
    node._parent = nil
    self._size = self._size - 1   -- reduce size from: removed node

    if not promote_children then   -- delete subtree
        -- reduce size from: lost subtrees/nodes
        self._size = self._size - (node:total_children())
    else
        if self._n then   -- promote max amount of children possible
            local num_of_children_to_promote = self._n - #parent_node._children
            local num_promoted_children = 0
            for i = 1, num_of_children_to_promote do
                -- if amount to promote > amount of children
                if not node._children[i] then break end
                node._children[i]._parent = parent_node
                table.insert(
                    parent_node._children,
                    removed_child_index + num_promoted_children,
                    node._children[i]
                )
                num_promoted_children = num_promoted_children + 1
            end
            -- remove lost children from self._size
            if num_of_children_to_promote < #node._children then
                for i = num_of_children_to_promote+1, #node._children do
                    self._size = self._size - (node._children[i]:total_children() + 1)
                end
            end

        else  -- promote all children
            for i = 1, #node._children do
                node._children[i]._parent = parent_node
                table.insert(parent_node._children, node._children[i])
            end
        end
    end
end

function MultiwayTree:clear()
    self._root = nil
    self._size = 0
end

return MultiwayTree