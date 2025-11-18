local Tests = require("tests")   -- common tests
package.path = package.path .. ";../?.lua;"
local MultiwayTree = require("multiway_tree")  -- import MultiwayTree
local MultiwayTreeNode = require("multiway_tree_node")  -- import MultiwayTreeNode
local Queue = require("queue")

function main()
    local my_tree = MultiwayTree:init(4)
    print("CREATED TREE: my_tree")
    print("my_tree:is_empty()=" .. tostring(my_tree:is_empty()))
    local nodes = {}
    for i = 1, 20 do
        nodes[#nodes+1] = MultiwayTreeNode:init(i)
    end
    my_tree:add_root(nodes[1])

    local queue = Queue:new()
    queue:enqueue(my_tree._root)

    for i = 2, #nodes do
        local current = queue:front()
        my_tree:add_child(current, nodes[i])
        queue:enqueue(nodes[i])

        if #current:children() >= my_tree:order() then
            queue:dequeue()
        end
    end
    local leaves = 0
    for i, node in pairs(my_tree:BFS()) do
        if my_tree:is_leaf(node) then
            leaves = leaves + 1
        end
    end
    print("\nAdded numbers 1 to 20")
    print("my_tree=" .. tostring(my_tree))
    print("my_tree:order()=" .. my_tree:order())
    print("#my_tree=" .. #my_tree)
    print("my_tree:is_empty()=" .. tostring(my_tree:is_empty()))
    print("LEAVES=" .. leaves)


    local new_tree = MultiwayTree:init(5)
    local new_nodes = {}
    for i = 1, 1000000 do
        new_nodes[#new_nodes+1] = MultiwayTreeNode:init(i)
    end
    print("\nAdd 1,000,000 nodes to order 5 tree test:")
    local one_million_elements = Tests.time_test(
        function()
            new_tree:add_root(new_nodes[1])
            local new_queue = Queue:new()
            new_queue:enqueue(new_tree._root)

            for i = 2, #new_nodes do
                local current = new_queue:front()
                new_tree:add_child(current, new_nodes[i])
                new_queue:enqueue(new_nodes[i])

                if #current:children() >= new_tree:order() then
                    new_queue:dequeue()
                end
            end
        end
    )
    print("Time: " .. one_million_elements .. " seconds")
end

if ... == nil then
    main()
end