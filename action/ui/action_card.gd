class_name ActionCard
extends Control

@onready var title: Label = %Title
@onready var description: Label = %Description
@onready var cost: Label = %Cost
@onready var cost_container: Control = %CostContainer
@onready var type: Label = %Type
@onready var picture: TextureRect = %Picture

signal action_card_clicked()

var fontScaleXTitle=5
var fontScaleYTitle=5
var fontScaleXSubtitle=6.5
var fontScaleYSubtitle=6.5
var fontScaleXText=8
var fontScaleYText=8
var scaleCardInside=0.85
var scalingPicture=3

func set_content(action: Action) -> void:
	title.text = action.title
	description.text = action.description
	picture.texture = action.texture
	_set_cost_text(action)
	_set_type_text(action)

func _set_type_text(action: Action) -> void:
	if action is BuildingAction:
		type.text = "Building"
	elif action is TerrainAction:
		type.text = "Terrain"
	else:
		printerr("No action type text set for: ", action.id)
		type.text = "Common"

func _set_cost_text(action: Action) -> void:
	if action is BuildingAction:
		cost_container.visible = true
		cost.text = str(action.building.cost.values()[0])
	else:
		cost_container.visible = false

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		emit_signal("action_card_clicked")
