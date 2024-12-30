local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local plr = Players.LocalPlayer
local screenGui = plr.PlayerGui:WaitForChild("ScreenGui")

local window = screenGui.Window
-- local A = screenGui.A
-- local B = screenGui.B

local SIZE_X = 3
local SIZE_Y = 3

local OSGL = require(ReplicatedStorage.OSGL)
local Window = OSGL.Window
local Texture = OSGL.Texture
local Video = OSGL.Video
local draw = OSGL.draw
local color = OSGL.color

local config = { sizeX = SIZE_X, sizeY = SIZE_Y }
local myWindow = Window.new(window, config)
myWindow.targetFPS = 270

local frames = script.frames
local video = Video.from({frames.A, frames.B, frames.C})
video.frameRate = 6
video.loop = true

video:PlaySync(function(texture)
    Texture.draw(myWindow, texture, 0, 0)
    myWindow:Render()
end)