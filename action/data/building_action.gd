class_name BuildingAction
extends Action

var building: Building

func _init(description: String, preview_image_path: String, building: Building) -> void:
	self.building = building
	super(building.name, description, preview_image_path)
