"use strict";(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[601],{17157:e=>{e.exports=JSON.parse('{"functions":[{"name":"ReadPixel","desc":"Reads a color on a window at the given location from the buffer\\n\\n```lua\\nlocal OSGL = require(path.to.osgl)\\nlocal Window = OSGL.Window\\nlocal color = OSGL.color\\n\\n-- Creates a new EditableImage\\nlocal myWindow = Window.new(path.to.parent, { sizeX = 50, sizeY = 50 })\\nmyWindow:WritePixel(0, 0, color.RED):Render()\\n\\nprint(\\n    myWindow:ReadPixel(0, 0) -- 255\\n)\\n```","params":[{"name":"x","desc":"X position","lua_type":"number"},{"name":"y","desc":"Y position","lua_type":"number"}],"returns":[{"desc":"","lua_type":"Color"}],"function_type":"static","source":{"line":131,"path":"src/DrawableObject/window.luau"}},{"name":"Draw","desc":"Returns the Window\'s [DrawingContext]\\n\\n```lua\\nlocal OSGL = require(path.to.osgl)\\nlocal Window = OSGL.Window\\nlocal color = OSGL.color\\n\\n-- Creates a new EditableImage\\nlocal myWindow = Window.new(path.to.parent, { sizeX = 50, sizeY = 50 })\\nmyWindow:Draw():Pixel(1, 1, color.RED):StopDrawing()\\n```","params":[],"returns":[{"desc":"","lua_type":"DrawingContext"}],"function_type":"static","source":{"line":339,"path":"src/DrawableObject/window.luau"}},{"name":"TintRegion","desc":"Tints a region of pixels\\n\\n```lua\\nlocal OSGL = require(path.to.osgl)\\nlocal Window = OSGL.Window\\nlocal color = OSGL.color\\n\\n-- Creates a new EditableImage\\nlocal myWindow = Window.new(path.to.parent, { sizeX = 50, sizeY = 50 })\\nmyWindow:TintRegion(color.RED, .5, 0, 0, 10, 10)\\n-- Tint pixels from 0, 0, with the\\n-- tinting region being 10x15 (150 pixels, from 0, 0) the color red, with\\n-- a tinting factor of .5\\n```","params":[],"returns":[{"desc":"","lua_type":"DrawableObject"}],"function_type":"static","source":{"line":361,"path":"src/DrawableObject/window.luau"}},{"name":"Serialize","desc":"Returns the object\'s buffer, as well as its width and height\\n\\n```lua\\n-- Save.luau\\nlocal bfr, width, height = myWindow:Serialize()\\n-- *save data*\\n\\n-- Load.luau\\nlocal bfr, width, height = -- *load data*\\nwindow:Deserialize(bfr, width, height)\\n```","params":[],"returns":[{"desc":"","lua_type":"(buffer, number, number)"}],"function_type":"static","source":{"line":380,"path":"src/DrawableObject/window.luau"}}],"properties":[{"name":"buffer","desc":"The buffer of the object","lua_type":"buffer","source":{"line":475,"path":"src/DrawableObject/texture.luau"}},{"name":"sizeX","desc":"The width of the object","lua_type":"number","source":{"line":481,"path":"src/DrawableObject/texture.luau"}},{"name":"sizeY","desc":"The height of the object","lua_type":"number","source":{"line":487,"path":"src/DrawableObject/texture.luau"}},{"name":"size","desc":"The size of the object","lua_type":"Vector2","source":{"line":493,"path":"src/DrawableObject/texture.luau"}}],"types":[{"name":"DrawableObject","desc":"A DrawableObject is an item that you can draw too. This can be\\na window, or a texture.\\n```lua\\nlocal OSGL = require(path.to.osgl)\\nlocal Window = OSGL.Window\\n\u200b\\n-- Creates a Window with a size of 50x50\\n-- This window is a DrawableObject\\nlocal myWindow = Window.new(path.to.instance, { sizeX = 50, sizeY = 50 })\\n```\\r","fields":[{"name":"buffer","lua_type":"buffer","desc":"The buffer of the object"},{"name":"sizeX","lua_type":"number","desc":"The width of the object."},{"name":"sizeY","lua_type":"number","desc":"The height of the object."},{"name":"size","lua_type":"Vector2","desc":"The size of the object as a Vector2"},{"name":"Draw","lua_type":"(self: DrawableObject<T>) -> DrawingContext<T>","desc":"Returns the drawing context of the object"},{"name":"TintRegion","lua_type":"(self: DrawableObject<T>, tint: Color, factor: number, x: number, y: number, width: number, height: number) ->  DrawingContext<T>","desc":"Tints a region of pixels"},{"name":"ReadPixel","lua_type":"(self: T, x: number, y: number) -> Color","desc":"Reads a pixel at the given X, Y"},{"name":"Serialize","lua_type":"(self: T) -> (buffer, number, number)","desc":"Returns the object\'s buffer, as well as its dimensions"}],"source":{"line":80,"path":"src/types.luau"}},{"name":"DrawingContext","desc":"The DrawingContext is a wrapper around [draw] that allows you to\\nto call the functions with your [DrawableObject] already passed as\\nthe first argument.\\n```lua\\nlocal OSGL = require(path.to.osgl)\\nlocal Window = OSGL.Window\\nlocal color = OSGL.color\\n\u200b\\n-- Creates a Window with a size of 50x50\\n-- This window is a DrawableObject\\nlocal myWindow = Window.new(path.to.instance, { sizeX = 50, sizeY = 50 })\\nmyWindow:Draw():Pixel(1, 1, color.RED):StopDrawing()\\n```\\r","fields":[{"name":"Pixel","lua_type":"(self: DrawingContext<V>, x: number, y: number, color: Color) -> DrawingContext<V>","desc":""},{"name":"Line","lua_type":"(self: DrawingContext<V>, startX: number, startY: number, stopX: number, stopY: number, thickness: number, color: Color) -> DrawingContext<V>","desc":""},{"name":"Rectangle","lua_type":"(self: DrawingContext<V>, xPos: number, yPos: number, width: number, height: number, fill: Color?, stroke: Color?, strokeThickness: number?, rotation: number?) -> DrawingContext<V>","desc":""},{"name":"Circle","lua_type":"(self: DrawingContext<V>, centerX: number, centerY: number, radius: number, fill: Color?, stroke: Color?, strokeThickness: number?, rotation: number?) -> DrawingContext<V>","desc":""},{"name":"Triangle","lua_type":"(self: DrawingContext<V>, x1: number, y1: number, x2: number, y2: number, x3: number, y3: number, fill: Color?, stroke: Color?, strokeThickness: number?) -> DrawingContext<V>","desc":""},{"name":"Polygon","lua_type":"(self: DrawingContext<V>, corners: {{number}}, fill: Color) -> DrawingContext<V>","desc":""},{"name":"FloodFill","lua_type":"(self: DrawableObject<V>, x: number, y: number, fill: Color) -> DrawingContext<V>","desc":""},{"name":"StopDrawing","lua_type":"(self: DrawingContext<V>) -> V","desc":""}],"source":{"line":165,"path":"src/types.luau"}}],"name":"DrawableObject","desc":"The DrawableObject class. This class represents\\nany item that you can draw to in OSGL, that be a\\ntexture or a window.","source":{"line":39,"path":"src/DrawableObject/utils.luau"}}')}}]);