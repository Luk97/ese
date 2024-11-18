extends CanvasLayer

signal round_finished()

@onready var round_counter_label: NinePatchRect = %RoundCounterLabel
@onready var wood_counter_label: NinePatchRect = %WoodCounterLabel

func set_round_count(rounds: int) -> void:
	round_counter_label.set_round_count(rounds)
	
func set_wood_count(wood_count: int) -> void:
	wood_counter_label.set_wood_count(wood_count)

func _on_finish_round_button_pressed() -> void:
	emit_signal("round_finished")
