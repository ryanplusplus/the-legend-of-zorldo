local loader = require 'lib/advanced-tiled-loader/Loader'

local function load_tile_map(level_file)
  local map = loader.load(level_file)
  map.drawObjects = false
  return map
end

local unique = {}

local function add_obstacle_tiles_to_world(map, world)
  local layer = map.layers['obstacle']
  for x = 1, map.width do
    for y = 1, map.height do
      local tile = layer(x - 1, y - 1)
      if tile then
        local block = {
          position = {
            x = (x - 1) * 16,
            y = (y - 1) * 16
          },
          size = {
            width = tile.width,
            height = tile.height
          },
          platform = true,
          solid = true
        }

        if tile.properties.half_collision then
          block.position.x = block.position.x + tile.width / 2
          block.size.width = tile.width / 2
        end

        world:add(block, block.position.x, block.position.y, block.size.width, block.size.height)
      end
    end
  end
end

local function extract_entities(map, entity_factories)
  local entities = {}
  for _, entity in pairs(map('entities').objects) do
    entity.properties.x = entity.x
    entity.properties.y = entity.y
    table.insert(entities, entity_factories[entity.properties.type](entity.properties))
  end
  return entities
end

return function(world, level_file, entity_factories)
  local map = load_tile_map(level_file)
  add_obstacle_tiles_to_world(map, world)
  local entities = extract_entities(map, entity_factories)
  return map, entities
end
