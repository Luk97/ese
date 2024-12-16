extends NinePatchRect

@onready var food_Progress_Button: Button = %food_Progress_Button
@onready var food_Progress_Bar: TextureProgressBar = %food_Progress_Bar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _set_new_heat_value(val: int)->void:
	food_Progress_Bar.value=val;
