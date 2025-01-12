extends Node

# Start values
const START_ROUNDS = 1
const START_WOOD = 20
const START_STONE = 10
const START_FOOD = 10

const START_WARMTH_NEED = 10
const START_FOOD_NEED = 10

# Global core variables
var rng = RandomNumberGenerator.new()
var show_world = false

# Game stats
@export var rounds: int = START_ROUNDS
@export var warmth_decrease = 1
@export var food_decrease = 1

# Global signals
signal round_updated(int)

# Global functions
func initialize_game() -> void:
	rng = RandomNumberGenerator.new()
	TileManager.reset_tiles()
	CameraController.setup()
	
	if not show_world:
		emit_signal("round_updated", rounds)
		ResourceManager.initialize_resources()

func update_rounds() -> void:
	rounds += 1
	emit_signal("round_updated", rounds)
