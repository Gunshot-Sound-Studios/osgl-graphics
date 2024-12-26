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
local color = OSGL.color
local draw = OSGL.draw

local myWindow =
	window.new(Players.LocalPlayer.PlayerGui:WaitForChild("ScreenGui").Window, { sizeX = SIZE_X, sizeY = SIZE_Y })

myWindow:AddRenderer(A, B)
myWindow:RemoveRenderer(B)

local txt = texture.fromAssetId(14419725604)

while task.wait() do
    texture.draw(myWindow, txt, 0, 0)
    myWindow:Render():Clear()
end
