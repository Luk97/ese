extends Label


func _ready() -> void:
	GameManager.round_updated.connect(set_round_count)

func set_round_count(rounds: int) -> void:
	text = str("Round: ", rounds)
