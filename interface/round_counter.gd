extends NinePatchRect

@onready var label = $RoundCounterLabel

var counter = 1

func increase_round_count() -> void:
	counter += 1
	label.text = "Round: " + str(counter)
