return function(world)
  return function(scene, dt)
    for entity in pairs(scene:entities_with('velocity', 'position', 'size', 'simple_collision')) do
      local collisions
      local resolved_x, resolved_y

      local dx = entity.velocity.x * dt
      local dy = entity.velocity.y * dt

      local target_x = entity.position.x + dx
      local target_y = entity.position.y + dy

      _, _, collisions = world:check(entity, target_x, target_y, function() return 'cross' end)

      resolved_x = target_x
      resolved_y = target_y

      for _, collision in pairs(collisions) do
        scene:new_entity({
          event = true,
          ran_into = {
            entity = entity,
            other = collision.other
          }
        })

        resolved_y = collision.touch.y
        resolved_x = collision.touch.x
      end

      entity.position.x = resolved_x
      entity.position.y = resolved_y

      world:update(entity, entity.position.x, entity.position.y)
    end
  end
end
