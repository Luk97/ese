extends Node2D

@onready var ground_layer: TileMapLayer = %GroundLayer

var tiles = {}

func place_tile(tile: Tile) -> void:
	tiles[tile.global_coords] = tile
	ground_layer.set_cell(tile.global_coords, tile.source_id, tile.atlas_coords)

func get_cursor_tile_coords() -> Vector2i:
	var local_mouse_coords = ground_layer.get_local_mouse_position()
	return ground_layer.local_to_map(local_mouse_coords) + Vector2i(1, 1)

# TODO: this doesn't take tile type in to account. For now, only water can be
# replaced. This returns a list of all the water tiles that neighbour a grass or forest tile.
# In the future this needs to check for the new_tile and adjust logic from there.
func find_possible_placements() -> Array:
	var possible_positions := []
	for coords in tiles.keys():
		
		# Check if tile could be generally replaced
		if tiles[coords].replaceable:
			var neighbours = ground_layer.get_surrounding_cells(coords)
			for neighbour in neighbours:
				if tiles.has(neighbour) and tiles[neighbour].name == "Grass":
					possible_positions.append(coords)
					break
			
	return possible_positions

func create_starter_tiles() -> void:
	
	# Temporary water range generation
	for x in range(-10, 10):
		for y in range(-10, 10):
			place_tile(WaterTile.new(Vector2i(x, y)))
	
	var starter_coords = Vector2i(0, 0)
	var tile = GrassTile.new(starter_coords)
	place_tile(tile)
	
