extends Node

# Start values
const START_ROUNDS = 1
const START_WOOD = 20
const START_WHEAT = 20

# Global core variables
var rng = RandomNumberGenerator.new()

# Game stats
@export var rounds: int = START_ROUNDS

# Global signals
signal round_updated(int)


# Global functions
func initialize_game() -> void:
	emit_signal("round_updated", rounds)
	ResourceManager.initialize_resources()



func update_rounds() -> void:
	rounds += 1
	emit_signal("round_updated", rounds)
