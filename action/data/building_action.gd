class_name BuildingAction
extends Action

var building: Building

func _init(building: Building) -> void:
	self.building = building
	super(building.name)
