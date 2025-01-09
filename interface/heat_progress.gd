extends NinePatchRect

@onready var heat_Progress_Button: Button = %heat_Progress_Button
@onready var heat_Progress_Bar: TextureProgressBar = %heat_Progress_Bar
@onready var progress_Bar: ProgressBar = %Progress_Bar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func setNewHeatValue(val: int)->void:
	heat_Progress_Bar.value=val;
	progress_Bar.value=val;
