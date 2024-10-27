class_name ChunkManager

const TILE_WIDTH := 32
const TILE_HEIGHT := 16
const CHUNK_SIZE := 8
const CHUNK_RADIUS := 8

const main_source := 0
const water = Vector2i(0, 0)
const grass = Vector2i(4, 0)
const forest = Vector2i(5, 0)

var chunks = {}
	
func updateChunks(layer: TileMapLayer):
	var center = CameraController.getGlobalPosition()
	for y in range(center.y - CHUNK_RADIUS, center.y + CHUNK_RADIUS + 1):
		for x in range(center.x - CHUNK_RADIUS, center.x + CHUNK_RADIUS + 1):
			var chunkPosition = Vector2(x, y)
			if not chunks.has(chunkPosition):
				var chunk = Chunk.new(chunkPosition)
				_load_chunk(chunk, layer)
				_save_chunk(chunk, layer)

	for chunk in chunks:
		if chunk is Chunk:
			if CHUNK_RADIUS < chunk.position.to_vector2().distance_to(center):
				_unload_chunk(chunk, layer)

func _load_chunk(chunk: Chunk, layer: TileMapLayer):
	var key = str(chunk.position)
	var newChunk = Chunk.new(chunk.position)
	
	if chunks.has(key):
		for tile_pos in chunks[key]["tiles"].keys():
			var tile = chunks[key]["tiles"][tile_pos]
			var tilePosition = Vector2(chunk.position.x * CHUNK_SIZE + tile_pos.x, chunk.position.y * CHUNK_SIZE + tile_pos.y)
			_set_tile(layer, tilePosition, main_source, tile)

	for y in range(CHUNK_SIZE):
		for x in range(CHUNK_SIZE):
			newChunk.tiles[y][x] = water
			var tilePosition = Vector2(chunk.position.x * CHUNK_SIZE + x, chunk.position.y * CHUNK_SIZE + y)
			_set_tile(layer, tilePosition, main_source, water)
	
	chunks[newChunk.position] = newChunk

func _unload_chunk(chunk: Chunk, layer: TileMapLayer):
	for y in range(CHUNK_SIZE):
		for x in range(CHUNK_SIZE):
			layer.set_cell(Vector2(chunk.x * CHUNK_SIZE + x, chunk.y * CHUNK_SIZE + y), -1)
	chunks.erase(chunk)

func _save_chunk(chunk: Chunk, layer: TileMapLayer):
	var key = str(chunk.position)
	if not chunks.has(chunk):
		chunks[key] = chunk
	var only_water = true
	for y in range(CHUNK_SIZE):
		for x in range(CHUNK_SIZE):
			var tile = layer.get_cell_atlas_coords(Vector2(chunk.position.x * CHUNK_SIZE + x, chunk.position.y * CHUNK_SIZE + y))
			if tile != water:
				chunk.tiles[y][x] = tile
				only_water = false
	
	if only_water:
		chunks.erase(key)
	else:
		print("[DEBUG] Chunk " + key + " saved!")
		
func _set_tile(layer: TileMapLayer, coords: Vector2i, source: int, tile: Vector2):
	if layer.get_cell_atlas_coords(coords) == Vector2i(-1, -1):
		layer.set_cell(coords, source, tile)
