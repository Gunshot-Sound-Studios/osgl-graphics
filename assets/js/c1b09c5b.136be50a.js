"use strict";(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[710],{57314:e=>{e.exports=JSON.parse('{"functions":[{"name":"from","desc":"Loads a texture from a string, or a module that returns a string.\\n\\n```lua\\nlocal OSGL = require(path.to.osgl)\\nlocal Window = OSGL.Window\\nlocal texture = OSGL.texture\\n\u200b\\n-- Creates a window from an existing EditableImage\\nlocal myWindow = Window.from(path.to.editableImage, { sizeX = 50, sizeY = 50 })\\n\\nlocal txt = texture.from(script.ModuleThatReturnsTexture)\\n```","params":[{"name":"textureData","desc":"The string that was generated by the `converter` exe","lua_type":"FlagTexture | ModuleScript"}],"returns":[{"desc":"","lua_type":"types.Texture<P>\\r\\n"}],"function_type":"static","source":{"line":84,"path":"src/DrawableObject/sprite/texture.luau"}},{"name":"new","desc":"Creates a texture of the given width and height\\n\\n```lua\\nlocal OSGL = require(path.to.osgl)\\nlocal Window = OSGL.Window\\nlocal texture = OSGL.texture\\n\u200b\\n-- Creates a window from an existing EditableImage\\nlocal myWindow = Window.from(path.to.editableImage, { sizeX = 50, sizeY = 50 })\\n\\nlocal txt = texture.new(50, 50)\\n```","params":[{"name":"sizeX","desc":"The width of the texture","lua_type":"number"},{"name":"sizeY","desc":"The height of the texture","lua_type":"number"}],"returns":[{"desc":"The final texture","lua_type":"Texture"}],"function_type":"static","source":{"line":111,"path":"src/DrawableObject/sprite/texture.luau"}},{"name":"read","desc":"Reads the desired chunk from a DrawableObject object\\n\\n```lua\\nlocal OSGL = require(path.to.osgl)\\nlocal Window = OSGL.Window\\nlocal texture = OSGL.texture\\n\u200b\\n-- Creates a window from an existing EditableImage\\nlocal myWindow = Window.from(path.to.editableImage, { sizeX = 50, sizeY = 50 })\\n\\n-- *Draw somthing here*\\n\\n-- Read a 5x5 square chunk, with the top-left corner\\n-- being at 0, 0. This will return an array of colors\\n-- of length 25 (assuming the window isn\'t smaller than 5x5 pixels)\\nprint(texture.read(myWindow, 0, 0, 5, 5))\\n```","params":[{"name":"from","desc":"The [DrawableObject] that will be read","lua_type":"DrawableObject"},{"name":"x","desc":"The X position of the area that will be read","lua_type":"number"},{"name":"y","desc":"The position of the area that will be read","lua_type":"number"},{"name":"xSize","desc":"The X-Size of the chunk. Defaults to 1","lua_type":"number?"},{"name":"ySize","desc":"The Y-Size of the chunk. Defaults to 1","lua_type":"number?"}],"returns":[{"desc":"The colors in the specified chunk","lua_type":"{types.Color}"}],"function_type":"static","errors":[{"lua_type":"\\"X\\"","desc":"This error occurs if the X is less than 0"},{"lua_type":"\\"Y\\"","desc":"This error occurs if the Y is less than 0"},{"lua_type":"\\"XSize\\"","desc":"This error occurs if the XSize is less than 1"},{"lua_type":"\\"YSize\\"","desc":"This error occurs if the YSize is less than 1"}],"source":{"line":161,"path":"src/DrawableObject/sprite/texture.luau"}}],"properties":[],"types":[{"name":"FlagTexture","desc":"The representation of a texture made with the `converter` exe provided with the module.\\r","lua_type":"{ width: number, height: number, pixels: { Color | string }, }","source":{"line":89,"path":"src/types.luau"}},{"name":"Texture","desc":"A `Texture` can be drawn onto a [Sprite] to be displayed on-screen.\\nTextures are simply a wrapper over our internal `PixelStorage`.\\r","fields":[{"name":"pixelStorage","lua_type":"PixelStorage","desc":"The raw-bytes of the texture"},{"name":"sizeX","lua_type":"number","desc":"The width of the texture"},{"name":"sizeY","lua_type":"number","desc":"The height of the texture"}],"source":{"line":103,"path":"src/types.luau"}}],"name":"Texture","desc":"The Texture class. Handles loading textures into memory\\nfor further use with sprites. Inherits everything from [DrawableObject].","source":{"line":38,"path":"src/DrawableObject/sprite/texture.luau"}}')}}]);