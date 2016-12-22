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
        if collision.other.platform and collision.normal.y ~= 0 then
          if collision.otherRect.x + collision.otherRect.w - entity.position.x <= 5 then
            entity.position.x, entity.position.y = world:move(
              entity,
              collision.otherRect.x + collision.otherRect.w,
              target_y,
              function() return 'cross' end
            )
          elseif entity.position.x + entity.size.width - collision.otherRect.x <= 5 then
            entity.position.x, entity.position.y = world:move(
              entity,
              collision.otherRect.x - entity.size.width,
              target_y,
              function() return 'cross' end
            )
          end
        end
      end

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
