local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local plr = Players.LocalPlayer
local screenGui = plr.PlayerGui:WaitForChild("ScreenGui")

local window = screenGui.Window
local A = screenGui.A
local B = screenGui.B

local SIZE_X = 570 * 1.7
local SIZE_Y = 409 * 1.7

local OSGL = require(ReplicatedStorage.OSGL)
local Window = OSGL.Window
local texture = OSGL.Texture
local draw = OSGL.draw
local color = OSGL.color


local config = { sizeX = SIZE_X, sizeY = SIZE_Y }
local myWindow = Window.new(window, config)
myWindow.targetFPS = 275

local txt = texture.fromAssetId(94762137675783)

local floor = math.floor
local i = 0
local x = floor(SIZE_X/2.5)
local y = floor(SIZE_Y/2.5)
while task.wait() do
    texture.drawRotated(myWindow, txt, x, y, i)
    myWindow:Render():Clear()

    i += 2
end
