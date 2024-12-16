extends CanvasLayer

@onready var wood_label: NinePatchRect = %WoodLabel
@onready var wheat_label: NinePatchRect = %WheatLabel
@onready var food_Progress: NinePatchRect = %food_Progress
@onready var heat_Progress: NinePatchRect = %heat_Progress

signal round_finished

func _ready() -> void:
	ResourceManager.wood_updated.connect(update_wood_label)
	ResourceManager.wheat_updated.connect(update_wheat_label)

func _on_finish_round_button_pressed() -> void:
	emit_signal("round_finished")

func update_wood_label(wood: int) -> void:
	wood_label.set_resource_count(wood)

func update_wheat_label(wheat: int) -> void:
	wheat_label.set_resource_count(wheat)
