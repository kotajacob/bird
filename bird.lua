local class = require 'lib/middleclass'

Bird = class('Bird')

function Bird:initialize(x, y)
    -- create the bird
    self.w = 30
    self.h = 25
    self.x = x
    self.y = y
    self.originalX = x
    self.originalY = y
    self.vspeed = 0

    -- create a font
    mainFont = love.graphics.newFont('assets/fonts/LiberationSans-Bold.ttf', 32)
end

function Bird:update(gravity, controlPipe, dt)
    -- change the speed of the bird with gravity
    self.vspeed = self.vspeed + (gravity * dt)

    -- change the location of the bird with speed
    self.y = self.y + (self.vspeed * dt)

    -- check if the bird collides with a pipe
    for i,v in ipairs(controlPipe) do
        -- check with each pipe
        px, py, pw, ph = v:getCords()

        if self.x+self.w > px and self.x < px+pw then
            if self.y < py or self.y+self.h > py+ph then
                -- this means we're hitting the pipe
                SCORE = 0
                table.remove(controlPipe, 1)
                table.remove(controlPipe, 1)
                self.x = self.originalX
                self.y = self.originalY
                self.vspeed = 0
            end
        end
    end
end

function Bird:jump()
    -- make the bird jump
    if self.y > 0 then -- if the bird is below the top of the map and has pressed a button make then jump
        self.vspeed = -272
    end
end

function Bird:draw(score)
    -- draw the bird
    love.graphics.setColor(224, 214, 68)
    love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)

    -- draw the score
    love.graphics.setColor(232, 232, 232)
    love.graphics.setFont(mainFont)
    love.graphics.print(SCORE, 0, 0)
end
