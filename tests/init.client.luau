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
local Window = OSGL.Window
local texture = OSGL.Texture
local draw = OSGL.draw
local color = OSGL.color


local config = { sizeX = SIZE_X, sizeY = SIZE_Y }
local myWindow = Window.new(window, config)

local txt = texture.fromAssetId(94762137675783)
texture.draw(myWindow, txt, 0, 0)

local buffer, w, h = myWindow:Serialize()

local secondWindow = Window.new(A, config)
secondWindow:AddRenderer(B)
secondWindow:Deserialize(buffer, w, h)

while task.wait() do
    secondWindow:Render()
end
