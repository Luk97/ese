extends NinePatchRect

@onready var food_Progress_Button: Button = %food_Progress_Button
@onready var food_Progress_Bar: TextureProgressBar = %food_Progress_Bar
@onready var progress_Bar: ProgressBar = %Progress_Bar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func setNewFoodValue(val: int)->void:
	food_Progress_Bar.value=val;
	progress_Bar.value=val;
