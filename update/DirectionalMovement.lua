return function(key_held)
  return function(scene, dt)
    for entity in pairs(scene:entities_with('animation', 'velocity', 'directional_movement', 'direction')) do
      entity.velocity.x = 0
      entity.velocity.y = 0

      if key_held[entity.directional_movement.left_key] then
        entity.velocity.x = -entity.directional_movement.speed
        entity.direction = 'w'
      elseif key_held[entity.directional_movement.right_key] then
        entity.velocity.x = entity.directional_movement.speed
        entity.direction = 'e'
      elseif key_held[entity.directional_movement.up_key] then
        entity.velocity.y = -entity.directional_movement.speed
        entity.direction = 'n'
      elseif key_held[entity.directional_movement.down_key] then
        entity.velocity.y = entity.directional_movement.speed
        entity.direction = 's'
      end
    end
  end
end
