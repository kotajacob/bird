local class = require 'lib/middleclass'

Pipe = class('Pipe')

function Pipe:initialize(x, padding)
    -- create the pipe
    self.w = 54
    self.h = 128
    self.x = x
    self.y = math.random(10, SCREEN_H - self.h - 10)
    self.speed = 100
    self.scored = 0
    self.scorePad = padding
end

function Pipe:update(controlPipe, dt)
    -- move the pipe
    self.x = self.x - (self.speed * dt)

    -- score if we pass the player
    if self.x+self.w < padding then
        if self.scored == 0 then
            -- add 1 to the score
            SCORE = SCORE + 1
            self.scored = 1
        end
    end

    -- remove a value
    if self.x <= -self.w then
        table.remove(controlPipe, 1)
    end
end

function Pipe:getCords()
    return self.x, self.y, self.w, self.h
end

function Pipe:draw()
    -- draw the walls
    love.graphics.setColor(94, 201, 72)
    love.graphics.rectangle("fill", self.x, 0, self.w, self.y) -- top part
    love.graphics.rectangle("fill", self.x, self.y + self.h, self.w, SCREEN_H) -- bottom part
end
