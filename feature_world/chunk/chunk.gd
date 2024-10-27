class_name Chunk

var position: Vector2
var tiles: Array = [8, 8]

func _init(pos: Vector2):
	position = pos
	initialize_tiles()

func initialize_tiles():
	tiles.clear()
	for i in range(ChunkManager.CHUNK_SIZE):
		var row = []
		for j in range(ChunkManager.CHUNK_SIZE):
			row.append(0)
		tiles.append(row)

func set_tile(x: int, y: int, value: int):
	if x >= 0 and x < ChunkManager.CHUNK_SIZE and y >= 0 and y < ChunkManager.CHUNK_SIZE:
		tiles[x][y] = value
	else:
		print("Tile position out of bounds")

func get_tile(x: int, y: int) -> int:
	if x >= 0 and x < ChunkManager.CHUNK_SIZE and y >= 0 and y < ChunkManager.CHUNK_SIZE:
		return tiles[x][y]
	else:
		print("Tile position out of bounds")
		return -1
