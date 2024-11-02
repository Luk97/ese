extends Node2D

@onready var ground_layer: TileMapLayer = %GroundLayer

# TODO: this doesn't take tile type in to account. For now, only water can be
# replaced. This returns a list of all the water tiles that neighbour a grass or forest tile.
# In the future this needs to check for the new_tile and adjust logic from there.
func find_possible_placements(new_tile: String) -> Array:
	var possible_positions := []
	var tiles = ground_layer.get_used_cells()
	for tile in tiles:
		
		if _is_water_tile(tile):
			continue
			
		var possible_neighbours = _get_valid_neighbours(tile)
		possible_positions.append_array(possible_neighbours)
		
	return possible_positions
	
func _is_water_tile(tile_coords: Vector2i) -> bool:
	var data = ground_layer.get_cell_tile_data(tile_coords)
	return data and data.get_custom_data("Name") == "Water"

func _get_valid_neighbours(tile_coords: Vector2i) -> Array:
	var possible_positions := []
	var neighbours = ground_layer.get_surrounding_cells(tile_coords)
	for neighbour in neighbours:
		var neighbour_data = ground_layer.get_cell_tile_data(neighbour)
		if neighbour_data and neighbour_data.get_custom_data("Name") == "Water":
			possible_positions.append(neighbour)
	return possible_positions
