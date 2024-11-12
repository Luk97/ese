class_name Action
extends Object

enum ActionType {
	BUILDING,
	#QUEST
}

var name: String
var type: ActionType

func _init(name: String, type: ActionType) -> void:
	self.name = name
	self.type = type
