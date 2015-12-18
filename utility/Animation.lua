local anim8 = require 'lib/anim8/anim8'

local Animation = {}
Animation.__index = Animation

function Animation:update(dt)
  self.animation:update(dt)
end

function Animation:render(x, y)
  self.animation:draw(self.sprites, x + self.offset.x, y + self.offset.y)
end

function Animation:reset()
  self.animation:gotoFrame(1)
  self.animation:resume()
end

function Animation:clone()
  local clone = {
    offset = self.offset,
    animation = self.animation:clone(),
    sprites = self.sprites
  }

  return setmetatable(clone, Animation)
end

function Animation:is_complete()
  return self.animation.status == 'paused'
end

return function(config)
  local sprites = love.graphics.newImage(config.sprites)
  local frame_width = config.sprite_width or sprites:getHeight()
  local frame_count = sprites:getWidth() / frame_width
  local grid = anim8.newGrid(frame_width, sprites:getHeight(), sprites:getWidth(), sprites:getHeight())


  local loop = (config.once and 'pauseAtEnd') or nil
  local animation = anim8.newAnimation(grid:getFrames('1-' .. tostring(frame_count), 1), config.frame_time, loop)

  if config.flip_horizontal then
    animation:flipH()
  end

  local animation = {
    offset = config.offsets or { x = 0, y = 0 },
    animation = animation,
    sprites = sprites
  }

  return setmetatable(animation, Animation)
end
