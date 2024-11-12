class_name BuildingAction
extends Action

var building: Building

func _init(building: Building) -> void:
	self.building = building
	var name = building.name
	var type = ActionType.BUILDING
	super(name, type)
