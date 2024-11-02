extends Node2D
class_name ChunkManager

@onready var ground_layer: TileMapLayer = %GroundLayer

# TODO: this is not used yet. There needs to be a chunk system in the future.
var chunks = {}

# TODO: initialize chunks
func _ready() -> void:
	pass

# TODO: check chunk radius
func _process(delta: float) -> void:
	pass
