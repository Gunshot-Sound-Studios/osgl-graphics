local OSGL = script.Parent.Parent.OSGL
local types = require(OSGL.types)

local BaseTool = {}
BaseTool.__index = BaseTool

function BaseTool.new()
    local self = setmetatable({}, BaseTool)

    return self
end

function BaseTool:Equip(window)

end
function BaseTool:UnEquip()

end
function BaseTool:Update()

end
function BaseTool:HandleInput(input: InputObject)

end

return BaseTool
