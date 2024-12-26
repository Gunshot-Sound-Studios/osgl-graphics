local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local plr = Players.LocalPlayer
local screenGui = plr.PlayerGui:WaitForChild("ScreenGui")

local window = screenGui.Window
local A = screenGui.A
local B = screenGui.B

local SIZE_X = 500
local SIZE_Y = 500

local OSGL = require(ReplicatedStorage.OSGL)
local Window = OSGL.Window
local texture = OSGL.Texture
local draw = OSGL.draw
local color = OSGL.color

local config = { sizeX = SIZE_X, sizeY = SIZE_Y }
local myWindow = Window.new(window, config)
myWindow.targetFPS = 270

myWindow
    :Clear(color.BLACK)
    :Draw()
    :Circle(250, 250, 50, color.RED)
    :StopDrawing()
    :Render()