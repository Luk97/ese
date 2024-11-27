class_name BuildingAction
extends Action

var building: Building

func _init(description: String, image_path: String, building: Building) -> void:
	self.building = building
	super(building.name, description, image_path)
