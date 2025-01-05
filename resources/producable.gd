class_name Producable
extends Node

enum Type {
	wood
}

var type: Type
var rate: int
var rounds_left: int
var prerequisites: Array

func _init(type: Type, rate: int) -> void:
	self.rate = rate
	self.rounds_left = rate
	self.prerequisites = prerequisites
