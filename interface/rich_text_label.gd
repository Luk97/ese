extends RichTextLabel


@onready var wood_counter_label: Label = %WoodCounterLabel

func set_wood_count(wood_count: int) -> void:
	wood_counter_label.text = str(wood_count)
