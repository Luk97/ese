class_name Action
extends Node

@export var id: String
@export var title: String
@export var description: String
@export var texture: Texture

func _init(id: String, title: String, description: String, texture: Texture) -> void:
	self.id = id
	self.title = title
	self.description = description
	self.texture = texture

func is_valid_tile(tile: Tile) -> bool:
	printerr("default implementation of base class action used.")
	return false
