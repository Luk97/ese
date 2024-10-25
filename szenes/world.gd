extends Node2D

@export var groundLayer: TileMapLayer
@export var worldLayer: TileMapLayer
@export var skyLayer: TileMapLayer

const source := 0
const block = Vector2i(0, 0)
const water = Vector2i(2, 0)

const TILE_WIDTH := 32
const TILE_HEIGHT := 16

const CHUNK_SIZE := 8
const RADIUS := 8

var current_chunk = Vector2()
var chunks = {}

var chunk_data = {
	"position": Vector2(),
	"tiles": {}
}

func _ready() -> void:
	set_tile(groundLayer, Vector2i(0, 0), source, block)
	update_chunks(get_current_chunk())

func _process(delta: float) -> void:
	var chunk = get_current_chunk()
	if current_chunk != chunk:
		current_chunk = chunk
		update_chunks(chunk)

func get_current_chunk() -> Vector2:
	var camera = get_viewport().get_camera_2d().global_position
	var isometric_width = ((8 * TILE_WIDTH) + (7 * TILE_HEIGHT)) / CHUNK_SIZE
	var isometric_x = (camera.x / isometric_width) + (camera.y / TILE_HEIGHT)
	var isometric_y = (camera.y / TILE_HEIGHT) - (camera.x / isometric_width)
	return Vector2(floor(isometric_x / CHUNK_SIZE), floor(isometric_y / CHUNK_SIZE))

func update_chunks(center: Vector2):
	for y in range(center.y - RADIUS, center.y + RADIUS + 1):
		for x in range(center.x - RADIUS, center.x + RADIUS + 1):
			var chunk = Vector2(x, y)
			if not chunks.has(chunk):
				load_chunk(chunk)
				save_chunk(chunk)
	
	for chunk in chunks.keys():
		if RADIUS < chunk.distance_to(center):
			unload_chunk(chunk)

func load_chunk(chunk):
	var key = str(chunk)
	if chunk_data.has(key):
		for tile_pos in chunk_data[key]["tiles"].keys():
			var tile = chunk_data[key]["tiles"][tile_pos]
			var position = Vector2i(chunk.x * CHUNK_SIZE + tile_pos.x, chunk.y * CHUNK_SIZE + tile_pos.y)
			set_tile(groundLayer, position, source, tile)
	
	for y in range(CHUNK_SIZE):
		for x in range(CHUNK_SIZE):
			set_tile(groundLayer, Vector2i(chunk.x * CHUNK_SIZE + x, chunk.y * CHUNK_SIZE + y), source, water)
	chunks[chunk] = true

func unload_chunk(chunk):
	for y in range(CHUNK_SIZE):
		for x in range(CHUNK_SIZE):
			groundLayer.set_cell(Vector2i(chunk.x * CHUNK_SIZE + x, chunk.y * CHUNK_SIZE + y), -1)
	chunks.erase(chunk)

func save_chunk(chunk: Vector2):
	var key = str(chunk)
	if not chunk_data.has(chunk):
		chunk_data[key] = {
			"position": chunk,
			"tiles": {}
		}
	var only_water = true
	for y in range(CHUNK_SIZE):
		for x in range(CHUNK_SIZE):
			var tile = groundLayer.get_cell_atlas_coords(Vector2i(chunk.x * CHUNK_SIZE + x, chunk.y * CHUNK_SIZE + y))
			if tile != water:
				print("[DEBUG] Tile: " + str(tile))
				chunk_data[key]["tiles"][Vector2i(x, y)] = tile
				only_water = false
	
	if only_water:
		chunk_data.erase(key)
	else:
		print("[DEBUG] Chunk " + key + " saved!")

func set_tile(layer: TileMapLayer, coords: Vector2i, source: int, tile: Vector2):
	if layer.get_cell_atlas_coords(coords) == Vector2i(-1, -1):
		layer.set_cell(coords, source, tile)
