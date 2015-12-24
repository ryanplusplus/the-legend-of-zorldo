return function(world)
  return function(scene, dt)
    for entity in pairs(scene:entities_with('velocity', 'position', 'size', 'simple_collision')) do
      local collisions
      local dx = entity.velocity.x * dt
      local dy = entity.velocity.y * dt

      local target_x = entity.position.x + dx
      local target_y = entity.position.y + dy

      entity.position.x, entity.position.y, collisions = world:move(
        entity,
        target_x,
        target_y,
        function() return 'touch' end
      )

      for _, collision in pairs(collisions) do
        scene:new_entity({
          event = true,
          ran_into = {
            entity = entity,
            other = collision.other
          }
        })
      end
    end
  end
end
