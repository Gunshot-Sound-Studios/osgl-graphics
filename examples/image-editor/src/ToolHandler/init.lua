local ToolHandler = {}
ToolHandler.__index = ToolHandler

function ToolHandler.new()
    local self = setmetatable({}, ToolHandler)

    return self
end

return ToolHandler
