---@diagnostic disable: lowercase-global
local util = require "luassert.util"

local a = require "mason-core.async"

function async_test(suspend_fn)
    return function()
        local ok, err = pcall(a.run_blocking, suspend_fn)
        if not ok then
            error(err, util.errorlevel())
        end
    end
end

local TableMock = {}
TableMock.__index = TableMock

function TableMock.new(tbl, key)
    return setmetatable({
        tbl = tbl,
        key = key,
    }, TableMock)
end

function TableMock:apply(value)
    self.original_value = self.tbl[self.key]
    self.tbl[self.key] = value
end

function TableMock:revert()
    self.tbl[self.key] = self.original_value
end

-- selene: allow(incorrect_standard_library_use)
mockx = {
    just_runs = function() end,
    returns = function(val)
        return function()
            return val
        end
    end,
    throws = function(exception)
        return function()
            error(exception, 2)
        end
    end,
    table = function(tbl, key, new_value)
        local mock = TableMock.new(tbl, key)
        mock:apply(new_value)
        assert:add_spy(mock)
        return mock
    end,
}
