extends Label

var holz=0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	set_text(str(holz)+" Holz")
	pass

func getValue(name:String) ->int:
	if(name=="Holz"):
		return holz
	else:
		return 0
	pass
	
