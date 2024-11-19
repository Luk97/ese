extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _pressed() -> void:
	print("Beendet")
	_disableButton()

func _disableButton() -> void:
	disabled=true
	get_tree().quit()

func _enableButton() -> void:
	disabled=false
	
