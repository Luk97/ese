extends NinePatchRect

@onready var food_Progress_Button: Button = %food_Progress_Button
@onready var food_Progress_Bar: TextureProgressBar = %food_Progress_Bar
@onready var progress_Bar: ProgressBar = %Progress_Bar

signal bar_empty

func setNewFoodValue()->void:
	food_Progress_Bar.value = food_Progress_Bar.value - 1
	if food_Progress_Bar.value <= 0:
		emit_signal("bar_empty")
