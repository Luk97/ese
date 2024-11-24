class_name Action
extends Object

var title: String
var description: String
var preview_image_path: String

func _init(title: String, description: String, preview_image_path: String) -> void:
	self.title = title
	self.description = description
	self.preview_image_path = preview_image_path
