local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local plr = Players.LocalPlayer
local screenGui = plr.PlayerGui:WaitForChild("ScreenGui")

local window = screenGui.Window
local A = screenGui.A
local B = screenGui.B

local SIZE_X = 570
local SIZE_Y = 409

local OSGL = require(ReplicatedStorage.OSGL)
local window = OSGL.Window
local texture = OSGL.Texture
local draw = OSGL.draw
local color = OSGL.color

local floor = math.floor

local myWindow =
	window.new(Players.LocalPlayer.PlayerGui:WaitForChild("ScreenGui").Window, { sizeX = SIZE_X, sizeY = SIZE_Y })

myWindow:AddRenderer(A, B)

local txt = texture.fromAssetId(14419725604)
texture.draw(myWindow, txt, 0, 0)
draw.floodFill(myWindow, 0, 0, color.RED)
myWindow:Render()
