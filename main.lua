--[[
#----------------------------------#
# ,--. ,--.         ,--.           #
# |  .'   / ,---. ,-'  '-. ,--,--. #
# |  .   ' | .-. |'-.  .-'' ,-.  | #
# |  |\   \' '-' '  |  |  \ '-'  | #
# `--' '--' `---'   `--'   `--`--' #
#            kotajacob.tk          #
# Copyright (C) 2017  Dakota Walsh #
#----------------------------------#
--]]

-- import libs
local class = require 'lib/middleclass'
local tick = require 'lib/tick'

-- import other files
require 'bird'
require 'pipe'

-- set screen constants
SCREEN_W = love.graphics.getWidth()
SCREEN_H = love.graphics.getHeight()
SCORE = 0

-- set the random seed
math.randomseed(os.time())

function love.load()
    -- set the background color to a light blue
    love.graphics.setBackgroundColor(35, 92, 118)

    -- create variables for the world
    padding = 62
    gravity = 516

    -- create the bird
    playerBird = Bird:new(padding, SCREEN_H/2)

    -- create the pipes
    controlPipe = {}

    -- create a tick to make new pipes
    tick.recur(function() table.insert(controlPipe, Pipe:new(SCREEN_W, padding)) end, 2)
end

function love.update(dt)
    tick.update(dt) -- update tick

    playerBird:update(gravity, controlPipe, dt) -- update the bird

    for i,v in ipairs(controlPipe) do -- update the pipes
        v:update(controlPipe, dt)
    end
end

function love.keypressed(key)
    playerBird:keypressed() -- jump the bird
end

function love.draw()
    for i,v in ipairs(controlPipe) do -- draw the pipes
        v:draw()
    end

    playerBird:draw() -- draw the bird
end
