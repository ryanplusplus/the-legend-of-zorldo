local Animation = require 'utility/Animation'

return function(controls)
  return function(config)
    local controls = controls[config.name]

    local walk_e = Animation({
      sprites = 'res/player_walk_e.png',
      offsets = {
        x = -8,
        y = -16
      },
      frame_time = 0.1
    })

    local walk_w = Animation({
      sprites = 'res/player_walk_w.png',
      offsets = {
        x = -8,
        y = -16
      },
      frame_time = 0.1
    })

    local walk_n = Animation({
      sprites = 'res/player_walk_n.png',
      offsets = {
        x = -8,
        y = -16
      },
      frame_time = 0.25
    })

    local walk_s = Animation({
      sprites = 'res/player_walk_s.png',
      offsets = {
        x = -8,
        y = -16
      },
      frame_time = 0.1
    })

    local idle_e = Animation({
      sprites = 'res/player_idle_e.png',
      offsets = {
        x = -8,
        y = -16
      },
      frame_time = 0.1
    })

    local idle_w = Animation({
      sprites = 'res/player_idle_w.png',
      offsets = {
        x = -8,
        y = -16
      },
      frame_time = 0.1
    })

    local idle_n = Animation({
      sprites = 'res/player_idle_n.png',
      offsets = {
        x = -8,
        y = -16
      },
      frame_time = 0.1
    })

    local idle_s = Animation({
      sprites = 'res/player_idle_s.png',
      offsets = {
        x = -8,
        y = -16
      },
      frame_time = 0.1
    })

    local jump_e = Animation({
      sprites = 'res/player_jump_e.png',
      offsets = {
        x = -8,
        y = -16
      },
      frame_time = 0.05
    })

    local jump_w = Animation({
      sprites = 'res/player_jump_w.png',
      offsets = {
        x = -8,
        y = -16
      },
      frame_time = 0.05
    })

    local death = Animation({
      sprites = 'res/player_death.png',
      offsets = {
        x = -8,
        y = -16
      },
      frame_time = 0.1,
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
      direction = 'e',
      directional_movement = {
        left_key = controls.left,
        right_key = controls.right,
        up_key = controls.up,
        down_key = controls.down,
        speed = 115
      },
      on_ground = true,
      jump = {
        jumping = false,
        speed = 350,
        key = controls.jump
      },
      size = {
        width = 16,
        height = 8
      },
      animation = idle_e,
      movement_animations = {
        walk_e = walk_e,
        walk_w = walk_w,
        walk_n = walk_n,
        walk_s = walk_s,
        walk_ne = walk_e,
        walk_nw = walk_w,
        walk_se = walk_e,
        walk_sw = walk_w,
        air_e = jump_e,
        air_w = jump_w,
        idle_e = idle_e,
        idle_w = idle_w,
        idle_n = idle_n,
        idle_s = idle_s
      },
      add_to_world = true,
      player = true,
      respawn = function(entity)
        entity.position.x = config.x
        entity.position.y = config.y
        entity.direction = 'e'
        entity.velocity.y = 0
        entity.life = entity.initial_life
      end,
      lives = 3,
      name = config.name,
      death_animation = death,
      cannot_leave_map = true,
      score = 0,
      jump_damage = 10,
      damaged_when_run_into = true,
      life = 1,
      initial_life = 1,
      can_pickup_powerups = true,
      dies_when_off_stage = true,
      simple_collision = true,
      death_sound = 'res/blah.wav'
    }
  end
end
