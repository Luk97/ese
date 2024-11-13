extends Button

signal rundeBeendet
signal neueRunde

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if(neueRunde):
	#	_enableButton()
	pass

func _pressed() -> void:
	print("Runde beendet")
	rundeBeendet.emit()
	_disableButton()

func _disableButton() -> void:
	disabled=true

func _enableButton() -> void:
	disabled=false
	
