local OSGLTypes = require(script.Parent.OSGL).types

export type Tools = { BaseTool }

export type Cleanable = {
    _connections: { RBXScriptConnection },
    Clean: (self: Cleanable) -> (),
    Destroy: (self: Cleanable) -> (),
}

export type BaseTool = Cleanable & {
    Equip: (self: BaseTool, window: OSGLTypes.Window) -> (),
    UnEquip: (self: BaseTool, window: OSGLTypes.Window) -> (),
    Update: (self: BaseTool, window: OSGLTypes.Window) -> (),
    HandleInput: (self: BaseTool, input: InputObject) -> (),
}

export type ToolHandler = Cleanable & {}

return nil
