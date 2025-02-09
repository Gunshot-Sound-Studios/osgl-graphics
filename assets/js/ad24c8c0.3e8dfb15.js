"use strict";(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[898],{19777:e=>{e.exports=JSON.parse('{"functions":[{"name":"Draw","desc":"Draws text at a specific location on-screen\\n\\n```lua\\nlocal OSGL = require(path.to.osgl)\\nlocal Window = OSGL.Window\\nlocal Font = OSGL.Font\\nlocal color = OSGL.color\\n\\n-- Creates a Window with a size of 50x50\\n-- This window is a DrawableObject\\nlocal myWindow = Window.new(path.to.instance, { sizeX = 50, sizeY = 50 })\\n\\nlocal data = -- Reference to font\\nlocal font = Front.from(data)\\nfont:Draw(myWindow, \\"Hello!\\", 0, 0) -- Draw the font\\n```","params":[{"name":"self","desc":"","lua_type":"types.Font"},{"name":"object","desc":"A [DrawableObject]","lua_type":"types.DrawableObject<T>"},{"name":"text","desc":"The text to draw","lua_type":"string"},{"name":"x","desc":"X position","lua_type":"number"},{"name":"y","desc":"Y position","lua_type":"number"},{"name":"color","desc":"The color of the text","lua_type":"types.Color\\r\\n"}],"returns":[{"desc":"Returns itself.","lua_type":"Font"}],"function_type":"static","source":{"line":88,"path":"src/font.luau"}},{"name":"from","desc":"Creates a new font\\n\\n```lua\\nlocal OSGL = require(path.to.osgl)\\nlocal Window = OSGL.Window\\nlocal Font = OSGL.Font\\nlocal color = OSGL.color\\n\\n-- Creates a Window with a size of 50x50\\n-- This window is a DrawableObject\\nlocal myWindow = Window.new(path.to.instance, { sizeX = 50, sizeY = 50 })\\n\\nlocal font = Font.from(data)\\n```","params":[{"name":"data","desc":"The loaded font-date","lua_type":"types.StoredFont"}],"returns":[{"desc":"Returns a new font.","lua_type":"Font"}],"function_type":"static","source":{"line":176,"path":"src/font.luau"}}],"properties":[],"types":[{"name":"Glyph","desc":"The representation of a letter in a font made with the `converter` exe provided with the module.\\r","lua_type":"number | buffer | { number }","source":{"line":254,"path":"src/types.luau"}},{"name":"Glyphs","desc":"A group of letters\\r","lua_type":"{ [string]: Glyph }","source":{"line":261,"path":"src/types.luau"}},{"name":"StoredFont","desc":"The representation of a font made with the `converter` exe provided with the module.\\r","lua_type":"{ version: string, letters: Glyphs }","source":{"line":266,"path":"src/types.luau"}},{"name":"Font","desc":"A loaded font\\r","lua_type":"{ glyphs: Glyphs, spacing: number, linePadding: number }","source":{"line":275,"path":"src/types.luau"}}],"name":"Font","desc":"The Font class handles loading and rendering of fonts.","source":{"line":35,"path":"src/font.luau"}}')}}]);