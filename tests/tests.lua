local Tests = {}

function Tests.time_test(callback)
    local start_time = os.clock()
    callback()
    local end_time = os.clock()

    return end_time - start_time
end

return Tests