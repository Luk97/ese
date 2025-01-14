extends NinePatchRect

@onready var heat_Progress_Button: Button = %heat_Progress_Button
@onready var heat_Progress_Bar: TextureProgressBar = %heat_Progress_Bar
#@onready var progress_Bar: ProgressBar = %Progress_Bar
var costs


signal bar_empty
signal bar_increased

func enable_button() -> void:
	heat_Progress_Button.disabled = false

func disable_button() -> void:
	heat_Progress_Button.disabled = true

func decrease() -> void:
	heat_Progress_Bar.value = heat_Progress_Bar.value - 1
	if heat_Progress_Bar.value <= 0:
		emit_signal("bar_empty")

func increase() -> void:
	heat_Progress_Bar.value = heat_Progress_Bar.value + 1
	ResourceManager.update_resource(Types.ResourceType.WOOD, -GameManager.get_warmth_increase_cost())
	emit_signal("bar_increased")

func is_full() -> bool:
	return heat_Progress_Bar.value >= 10

func _on_heat_progress_button_pressed() -> void:
	increase()

func setTooltip(txt: String)->void:
	tooltip_text=txt
	heat_Progress_Button.tooltip_text=txt

func setCost(newCost:int)->void:
	costs=newCost
	var txt="Costs: %d Wood per step. If this bar runs out, your people froze to death!"
	txt=txt %costs
	setTooltip(txt)
