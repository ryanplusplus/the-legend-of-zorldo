function set_animation(entity, animation)
  if entity.animation ~= entity.movement_animations[animation] then
    entity.animation:reset()
  end

  entity.animation = entity.movement_animations[animation]
end

return function(scene, dt)
  for entity in pairs(scene:entities_with('animation', 'movement_animations', 'velocity', 'on_ground', 'direction')) do
    if entity.on_ground then
      if entity.velocity.x ~= 0 or entity.velocity.y ~= 0 then
        local animation = 'walk_'

        if entity.velocity.y > 0 then
          animation = animation .. 's'
        elseif entity.velocity.y < 0 then
          animation = animation .. 'n'
        end

        if entity.velocity.x > 0 then
          animation = animation .. 'e'
        elseif entity.velocity.x < 0 then
          animation = animation .. 'w'
        end

        set_animation(entity, animation)
      else
        set_animation(entity, 'idle_' .. entity.direction)
      end
    else
      set_animation(entity, 'air_' .. entity.direction)
    end
  end
end
