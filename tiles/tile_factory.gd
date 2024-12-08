extends Node

enum Type {
	Water,
	Grass,
	Forest
}

func create_tile(type: Type, coords: Vector2i) -> Tile:
	var tile: Tile = null
	match type:
		Type.Water:
			tile = load("res://tiles/data/water_tile.tres").duplicate()
		Type.Grass:
			tile = load("res://tiles/data/grass_tile.tres").duplicate()
		Type.Forest:
			tile = load("res://tiles/data/forest_tile.tres").duplicate()
	if tile:
		tile.map_coords = coords
		tile.decoration = DecorationManager.get_random_decoration(tile.name)
	return tile
