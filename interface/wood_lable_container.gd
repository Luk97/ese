extends GridContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

@onready var wood_counter_label: Label = %wood_counter_lable

func set_wood_count(wood_count: int) -> void:
	wood_counter_label.text = str("Wood:", wood_count)
