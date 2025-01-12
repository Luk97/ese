extends NinePatchRect

@onready var food_Progress_Button: Button = %food_Progress_Button
@onready var food_Progress_Bar: TextureProgressBar = %food_Progress_Bar
@onready var progress_Bar: ProgressBar = %Progress_Bar
var costs

signal bar_empty
signal bar_increased

func enable_button() -> void:
	food_Progress_Button.disabled = false

func disable_button() -> void:
	food_Progress_Button.disabled = true

func decrease() -> void:
	food_Progress_Bar.value = food_Progress_Bar.value - 1
	if food_Progress_Bar.value <= 0:
		emit_signal("bar_empty")

func increase() -> void:
	food_Progress_Bar.value = food_Progress_Bar.value + 1
	ResourceManager.update_resource(Types.ResourceType.FOOD, -GameManager.get_food_increase_cost())
	emit_signal("bar_increased")

func is_full() -> bool:
	return food_Progress_Bar.value >= 10

func _on_food_progress_button_pressed() -> void:
	increase()

func setTooltip(txt: String)->void:
	tooltip_text=txt

func setCost(newCost:int)->void:
	costs=newCost
	setTooltip("Costs: "+costs)
