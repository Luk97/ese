extends NinePatchRect

@onready var round_counter_label: Label = %RoundCounterLabel

func set_round_count(rounds: int) -> void:
	round_counter_label.text = str("Round: ", rounds)
