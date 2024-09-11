local OSGLTypes = require(script.Parent.OSGL).types

export type Tools<K = number> = { [K]: BaseTool }

export type Cleanable = {
    _connections: { RBXScriptConnection },
    Clean: (self: Cleanable) -> (),
    Destroy: (self: Cleanable) -> (),
}

export type BaseTool = Cleanable & {
    Equip: (self: BaseTool, window: OSGLTypes.Window) -> (),
    UnEquip: (self: BaseTool, window: OSGLTypes.Window) -> (),
    HandleInput: (self: BaseTool, input: InputObject, window: OSGLTypes.Window) -> (),
}

export type ToolHandler = Cleanable & {
    EquipTool: (self: ToolHandler, index: number) -> (),
    UnEquipTool: (self: ToolHandler, index: number) -> (),
}

return nil
