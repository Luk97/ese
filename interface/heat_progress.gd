extends NinePatchRect

@onready var heat_Progress_Button: Button = %heat_Progress_Button
@onready var heat_Progress_Bar: TextureProgressBar = %heat_Progress_Bar
@onready var progress_Bar: ProgressBar = %Progress_Bar

signal bar_empty

func setNewHeatValue()->void:
	heat_Progress_Bar.value = heat_Progress_Bar.value - 1
	if heat_Progress_Bar.value <= 0:
		emit_signal("bar_empty")
