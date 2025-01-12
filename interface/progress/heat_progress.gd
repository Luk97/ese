extends NinePatchRect

@onready var heat_Progress_Button: Button = %heat_Progress_Button
@onready var heat_Progress_Bar: TextureProgressBar = %heat_Progress_Bar
@onready var progress_Bar: ProgressBar = %Progress_Bar

signal bar_empty

func enable_button() -> void:
	heat_Progress_Button.visible = true

func disable_button() -> void:
	heat_Progress_Button.visible = false

func decrease() -> void:
	heat_Progress_Bar.value = heat_Progress_Bar.value - 1
	if heat_Progress_Bar.value <= 0:
		emit_signal("bar_empty")

func increase() -> void:
	heat_Progress_Bar.value = heat_Progress_Bar.value + 1
	ResourceManager.update_resource(Types.ResourceType.WOOD, GameManager.get_warmth_increase_cost())

func is_full() -> bool:
	return heat_Progress_Bar.value >= 10

func _on_heat_progress_button_pressed() -> void:
	increase()