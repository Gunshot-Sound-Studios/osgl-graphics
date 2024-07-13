--!optimize 2
--!strict


--========================================================================
-- OSGL 1.1
--------------------------------------------------------------------------
-- Copyright (c) 2023-2024 | Gunshot Sound Studios | ShadowX
--
-- This software is provided 'as-is', without any express or implied
-- warranty. In no event will the authors be held liable for any damages
-- arising from the use of this software.
--
-- Permission is granted to anyone to use this software for any purpose,
-- including commercial applications, and to alter it and redistribute it
-- freely, subject to the following restrictions:
--
-- 1. The origin of this software must not be misrepresented; you must not
--    claim that you wrote the original software. If you use this software
--    in a product, an acknowledgment in the product documentation would
--    be appreciated but is not required.
--
-- 2. Altered source versions must be plainly marked as such, and must not
--    be misrepresented as being the original software.
--
-- 3. This notice may not be removed or altered from any source
--    distribution.
--
--========================================================================

local Types = require(script.Parent.Types)
local Log = require(script.Parent.Log)
local Color = require(script.Parent.Color)
local Render = require(script.Parent.Window.Render)

local error = Log.error

local ShapePublic = {}

function ShapePublic.circle(CircleData: { Radius: number, Position: Vector2?, Color: Types.RGBA?})
	if not CircleData then
		error(`Function 'shape.circle requires all parameters to be passed.\nNo parameters were passed at all.\nDid you forget to pass them?`)
	end
	
	CircleData.Radius = CircleData.Radius or 1
	CircleData.Position = CircleData.Position or Vector2.one
	CircleData.Color = CircleData.Color or Color.Black
	
	return {
		Command = "Circle",
		Data = CircleData
	}
end

function ShapePublic.rectangle(RectData: { Size: Vector2, Position: Vector2?, Color: Types.RGBA?})
	if not RectData then
		error(`Function 'shape.rectangle requires all parameters to be passed.\nNo parameters were passed at all.\nDid you forget to pass them?`)
	end

	RectData.Size = RectData.Size or Vector2.one
	RectData.Position = RectData.Position or Vector2.one
	RectData.Color = RectData.Color or Color.Black

	return {
		Command = "Rect",
		Data = RectData
	}
end

function ShapePublic.triangle(TriData: { P1: Vector2, P2: Vector2, P3: Vector2, Color: Types.RGBA?})
	if not TriData or not TriData.P1 or not TriData.P2 or not TriData.P3 then
		error(`Function 'shape.rectangle requires all parameters to be passed.\nSome/ All parameters were not passed at all.\nDid you forget to pass them?`)
	end

	TriData.Color = TriData.Color or Color.Black

	return ShapePublic.convex({
		Color = TriData.Color,
		Verts = { TriData.P1, TriData.P2, TriData.P3 }
	})
end

function ShapePublic.polygon(PolyData: { Sides: number, Size: Vector2?, Position: Vector2?, Color: Types.RGBA?})
	if not PolyData then
		error(`Function 'shape.polygon requires all parameters to be passed.\nNo parameters were passed at all.\nDid you forget to pass them?`)
	end

	PolyData.Size = PolyData.Size or Vector2.one
	PolyData.Position = PolyData.Position or Vector2.one
	PolyData.Color = PolyData.Color or Color.Black
	PolyData.Sides = PolyData.Sides or 3
	
	PolyData.Sides = math.max(PolyData.Sides, 3)
	
	return {
		Command = "Poly",
		Data = PolyData
	}
end

function ShapePublic.convex(ConvexData: { Verts: {Vector2}, Color: Types.RGBA? })
	if not ConvexData then
		error(`Function 'shape.convex requires all parameters to be passed.\nNo parameters were passed at all.\nDid you forget to pass them?`)
	end
	
	ConvexData.Verts = ConvexData.Verts or { Vector2.zero, -Vector2.one, Vector2.new() }
	ConvexData.Color = ConvexData.Color or Color.Black
	
	if #ConvexData.Verts < 3 then
		error(`Function 'shape.convex' requires 'verts' to have atleast 3 elements in it.\nOnly {#ConvexData.Verts} were passed.`)
	end
	
	return {
		Command = "Convex",
		Data = ConvexData
	}
end

function ShapePublic.line(LineData: {P1: Vector2, P2: Vector2, Color: Types.RGBA?, Thickness: number? })
	if not LineData then
		error(`Function 'shape.line' requires all parameters to be passed.\nNo parameters were passed at all.\nDid you forget to pass them?`)
	end
	
	LineData.P1 = LineData.P1 or Vector2.zero
	LineData.P2 = LineData.P2 or Vector2.one
	LineData.Color = LineData.Color or Color.Black
	LineData.Thickness = LineData.Thickness or 1
	
	return {
		Command = "Line",
		Data = LineData
	}
end

function ShapePublic.pixel(Position: Vector2, PixelColor: Types.RGBA)
	
	Position = Position or Vector2.one
	PixelColor = PixelColor or Color.Black
	
	return {
		Command = "Pixel",
		Data = {
			Position = Position,
			Color = PixelColor
		}
	}
end

function ShapePublic.register(Name: string, constructor: () -> ({Command: string, Data: {[any?]: any?}}), callback: (Window: Types.WindowRenderingContext, self: Types.RenderCommand) -> ()): nil
	if not Name or not constructor or not callback then
		error("Function 'shape.register' requires all parameters to be passed.\nNot all of the parameters were passed.\nDid you forget to pass them?")
	end
	
	ShapePublic[Name] = constructor
	Render[Name] = callback
	
	return
end

return ShapePublic