extends Node

# Game stats
@export var rounds: int = 0

# Game resources
@export var wood: int = 0

# Global signals
signal round_updated(int)
signal wood_updated(int)

# Global functions
func update_rounds() -> void:
	rounds += 1
	emit_signal("round_updated", rounds)

func update_wood(change: int) -> void:
	wood += change
	emit_signal("wood_updated", wood)
