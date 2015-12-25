local Animation = require 'utility/Animation'
local GoldCoin = require 'entity/GoldCoin'
local SilverCoin = require 'entity/SilverCoin'

return function(config)
  local walk_e = Animation({
    sprites = 'res/enemy_walk_e.png',
    offsets = {
      x = -6,
      y = -6
    },
    frame_time = 0.05
  })

  local walk_w = Animation({
    sprites = 'res/enemy_walk_w.png',
    offsets = {
      x = -6,
      y = -6
    },
    frame_time = 0.05
  })

  local death_w = Animation({
    sprites = 'res/enemy_die_w.png',
    frame_time = 0.5,
    offsets = {
      x = -6,
      y = -6
    },
    once = true
  })

  local death_e = Animation({
    sprites = 'res/enemy_die_e.png',
    frame_time = 0.5,
    offsets = {
      x = -6,
      y = -6
    },
    once = true
  })

  return {
    position = {
      x = config.x,
      y = config.y
    },
    velocity = {
      x = 0,
      y = 0
    },
    direction = 'w',
    has_mass = true,
    on_ground = false,
    size = {
      width = 22,
      height = 26
    },
    animation = walk_e,
    movement_animations = {
      walk_e = walk_e,
      walk_w = walk_w,
      air_e = walk_e,
      air_w = walk_w,
      idle_e = walk_e,
      idle_w = walk_w
    },
    add_to_world = true,
    enemy = true,
    patrol_ai = {
      speed = 100
    },
    solid = true,
    bounciness = 0.9,
    death_animation = death_e,
    directional_death_animation = {
      e = death_e,
      w = death_w
    },
    points = 10,
    life = 15,
    damaged_when_jumped_on = true,
    damage_dealt_when_run_into = 10,
    one_way_platform_position = true,
    drops = {
      [GoldCoin()] = 1,
      [SilverCoin()] = 4
    },
    death_sound = 'res/squish.wav'
  }
end
