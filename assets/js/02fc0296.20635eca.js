"use strict";(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[240],{33248:o=>{o.exports=JSON.parse('{"functions":[{"name":"new","desc":"Creates a new color value. Values cannot be changed manually and must be changed\\nvia a function.\\n\\n```lua\\nlocal OSGL = require(path.to.osgl)\\nlocal color = OSGL.color\\n\\n-- All other parameters are defaulted\\n-- to 0, except for alpha, which is\\n-- defaulted to 255.\\nlocal myAwesomeRedColor = color.new(255)\\n```","params":[{"name":"r","desc":"","lua_type":"number?"},{"name":"g","desc":"","lua_type":"number?"},{"name":"b","desc":"","lua_type":"number?"},{"name":"a","desc":"","lua_type":"number?"}],"returns":[{"desc":"Returns a color Value","lua_type":"Color"}],"function_type":"static","source":{"line":56,"path":"src/color.luau"}},{"name":"newRGB","desc":"Creates a new color value with the alpha channel being 255. Values cannot be changed\\nmanually and must be changed via a function.\\n\\n```lua\\nlocal OSGL = require(path.to.osgl)\\nlocal color = OSGL.color\\n\\n-- All other parameters are defaulted\\n-- to 0.\\nlocal myAwesomeRedColor = color.newRGB(255)\\n```","params":[{"name":"r","desc":"","lua_type":"number?"},{"name":"g","desc":"","lua_type":"number?"},{"name":"b","desc":"","lua_type":"number?"}],"returns":[{"desc":"Returns a color Value","lua_type":"Color"}],"function_type":"static","source":{"line":86,"path":"src/color.luau"}},{"name":"setR","desc":"Sets the \'r\' channel of the color.\\n\\n```lua\\nlocal OSGL = require(path.to.osgl)\\nlocal color = OSGL.color\\n\\nlocal c = color.setR(color.RED, 100)\\nprint(color.r(c)) -- Ouput:  100\\n```\\n\\nFor performance boost, if you\'re creating colors using only 1 or 2 channels, you\\nshould do:\\n\\n```lua\\nlocal almostRed = color.setR(color.BLACK, 100)\\n```","params":[{"name":"c","desc":"The color to edit","lua_type":"Color"},{"name":"r","desc":"The new value","lua_type":"number"}],"returns":[{"desc":"","lua_type":"number"}],"function_type":"static","source":{"line":122,"path":"src/color.luau"}},{"name":"setG","desc":"Sets the \'g\' channel of the color.\\n\\n```lua\\nlocal OSGL = require(path.to.osgl)\\nlocal color = OSGL.color\\n\\nlocal c = color.setG(color.GREEN, 100)\\nprint(color.g(c)) -- Ouput:  100\\n```\\n\\nFor performance boost, if you\'re creating colors using only 1 or 2 channels, you\\nshould do:\\n\\n```lua\\nlocal almostGreen = color.setG(color.BLACK, 100)\\n```","params":[{"name":"c","desc":"The color to edit","lua_type":"Color"},{"name":"g","desc":"The new value","lua_type":"number"}],"returns":[{"desc":"","lua_type":"number"}],"function_type":"static","source":{"line":149,"path":"src/color.luau"}},{"name":"setB","desc":"Sets the \'b\' channel of the color.\\n\\n```lua\\nlocal OSGL = require(path.to.osgl)\\nlocal color = OSGL.color\\n\\nlocal c = color.setB(color.BLUE, 100)\\nprint(color.b(c)) -- Ouput:  100\\n```\\n\\nFor performance boost, if you\'re creating colors using only 1 or 2 channels, you\\nshould do:\\n\\n```lua\\nlocal almostBlue = color.setB(color.BLACK, 100)\\n```","params":[{"name":"c","desc":"The color to edit","lua_type":"Color"},{"name":"b","desc":"The new value","lua_type":"number"}],"returns":[{"desc":"","lua_type":"number"}],"function_type":"static","source":{"line":176,"path":"src/color.luau"}},{"name":"setA","desc":"Sets the \'a\' channel of the color.\\n\\n```lua\\nlocal OSGL = require(path.to.osgl)\\nlocal color = OSGL.color\\n\\nlocal c = color.setA(color.TRANSPARENT, 100)\\nprint(color.a(c)) -- Ouput:  100\\n```\\n\\nFor performance boost, if you\'re creating colors using only 1 or 2 channels, you\\nshould do:\\n\\n```lua\\nlocal almostBlack = color.setA(color.TRANSPARENT, 100)\\n```","params":[{"name":"c","desc":"The color to edit","lua_type":"Color"},{"name":"a","desc":"The new value","lua_type":"number"}],"returns":[{"desc":"","lua_type":"number"}],"function_type":"static","source":{"line":203,"path":"src/color.luau"}},{"name":"read","desc":"Reads the value of the color\\n\\n```lua\\nlocal OSGL = require(path.to.osgl)\\nlocal color = OSGL.color\\n\\n-- All other parameters are defaulted to 0, except for alpha,\\n-- which is defaulted to 255.\\nlocal myAwesomeRedColor = color.new(255)\\nprint(color.read(myAwesomeRedColor)) -- Output: { 255, 0, 0, 255 }\\n```","params":[{"name":"rgbaColor","desc":"The color to read","lua_type":"Color"}],"returns":[{"desc":"","lua_type":"{ number }"}],"function_type":"static","source":{"line":224,"path":"src/color.luau"}},{"name":"r","desc":"Reads the \'r\' value of the color\\n\\n```lua\\nlocal OSGL = require(path.to.osgl)\\nlocal color = OSGL.color\\n\\n-- All other parameters are defaulted to 0, except for alpha,\\n-- which is defaulted to 255.\\nlocal myAwesomeRedColor = color.new(255)\\nprint color.r(myAwesomeRedColor)) -- Ouput:  255\\n```","params":[{"name":"color","desc":"The color to read","lua_type":"Color"}],"returns":[{"desc":"","lua_type":"number"}],"function_type":"static","source":{"line":250,"path":"src/color.luau"}},{"name":"g","desc":"Reads the \'g\' value of the color\\n\\n```lua\\nlocal OSGL = require(path.to.osgl)\\nlocal color = OSGL.color\\n\\n-- All other parameters are defaulted to 0, except for alpha,\\n-- which is defaulted to 255.\\nlocal myAwesomeRedColor = color.new(255)\\nprint color.g(myAwesomeRedColor)) -- Ouput:  0\\n```","params":[{"name":"color","desc":"The color to read","lua_type":"Color"}],"returns":[{"desc":"","lua_type":"number"}],"function_type":"static","source":{"line":271,"path":"src/color.luau"}},{"name":"b","desc":"Reads the \'b\' value of the color\\n\\n```lua\\nlocal OSGL = require(path.to.osgl)\\nlocal color = OSGL.color\\n\\n-- All other parameters are defaulted to 0, except for alpha,\\n-- which is defaulted to 255.\\nlocal myAwesomeRedColor = color.new(255)\\nprint color.b(myAwesomeRedColor)) -- Ouput:  0\\n```","params":[{"name":"color","desc":"The color to read","lua_type":"Color"}],"returns":[{"desc":"","lua_type":"number"}],"function_type":"static","source":{"line":292,"path":"src/color.luau"}},{"name":"a","desc":"Reads the \'a\' value of the color\\n\\n```lua\\nlocal OSGL = require(path.to.osgl)\\nlocal color = OSGL.color\\n\\n-- All other parameters are defaulted to 0, except for alpha,\\n-- which is defaulted to 255.\\nlocal myAwesomeRedColor = color.new(255)\\nprint(color.a(myAwesomeRedColor)) -- Ouput:  255\\n```","params":[{"name":"color","desc":"The color to read","lua_type":"Color"}],"returns":[{"desc":"","lua_type":"number"}],"function_type":"static","source":{"line":313,"path":"src/color.luau"}},{"name":"tint","desc":"Tints the color towards the other color using a tint factor. A tint factor of 0\\nmeans `color1` will be returned, while a tint factor of 1 means `color2` will be\\nreturned.\\n\\n```lua\\nlocal OSGL = require(path.to.osgl)\\nlocal color = OSGL.color\\n\\nlocal whiteTintedRed = color.tint(color.WHITE, color.RED)\\n```","params":[{"name":"color1","desc":"The color to tint","lua_type":"Color"},{"name":"color2","desc":"The tint that will be applied","lua_type":"Color"},{"name":"factor","desc":"How strong the tint is","lua_type":"number"}],"returns":[{"desc":"","lua_type":"number"}],"function_type":"static","source":{"line":335,"path":"src/color.luau"}}],"properties":[{"name":"RED","desc":"A red color\\r","lua_type":"Color","source":{"line":353,"path":"src/color.luau"}},{"name":"GREEN","desc":"A green color\\r","lua_type":"Color","source":{"line":358,"path":"src/color.luau"}},{"name":"BLUE","desc":"A blue color\\r","lua_type":"color","source":{"line":363,"path":"src/color.luau"}},{"name":"WHITE","desc":"A white color\\r","lua_type":"Color","source":{"line":368,"path":"src/color.luau"}},{"name":"BLACK","desc":"A black color\\r","lua_type":"Color","source":{"line":373,"path":"src/color.luau"}},{"name":"YELLOW","desc":"A yellow color\\r","lua_type":"Color","source":{"line":378,"path":"src/color.luau"}},{"name":"MAGENTA","desc":"A magenta color\\r","lua_type":"Color","source":{"line":383,"path":"src/color.luau"}},{"name":"CYAN","desc":"A cyan color\\r","lua_type":"Color","source":{"line":388,"path":"src/color.luau"}},{"name":"TRANSPARENT","desc":"A completely transparent color\\r","lua_type":"Color","source":{"line":393,"path":"src/color.luau"}}],"types":[{"name":"Color","desc":"```lua\\nlocal OSGL = require(path.to.osgl)\\nlocal color = OSGL.color\\n\u200b\\n-- All other parameters are defaulted\\n-- to 0, except for alpha, which is\\n-- defaulted to 255.\\nlocal myAwesomeRedColor = color.new(255)\\n```\\r","lua_type":"number","source":{"line":39,"path":"src/types.luau"}}],"name":"Color","desc":"The color class. Handles manipulations of color values.","source":{"line":37,"path":"src/color.luau"}}')}}]);