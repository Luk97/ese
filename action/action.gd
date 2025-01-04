class_name Action
extends Node

@export var id: String
@export var type: Types.ActionType
@export var title: String
@export var description: String
@export var texture: Texture
@export var building: Building = null

func _init(id: String, type: Types.ActionType, title: String, description: String, texture: Texture, building: Building = null) -> void:
	self.id = id
	self.type = type
	self.title = title
	self.description = description
	self.texture = texture
	self.building = building
