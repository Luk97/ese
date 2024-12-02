class_name ActionCard
extends NinePatchRect

@onready var action_manager: ActionManager = %ActionManager
@onready var title: Label = %Title
@onready var description: Label = %Description
@onready var cost: Label = %Cost
@onready var cost_container: HBoxContainer = %CostContainer
@onready var type: Label = %Type
@onready var image: Sprite2D = %Image

signal action_card_clicked()

func set_content(action: Action) -> void:
	title.text = action.title
	type.text = _get_action_type(action)
	description.text = action.description
	image.texture = load(action.image_path)
	if action is BuildingAction:
		cost_container.visible = true
		cost.text = str(action.building.cost)
	else:
		cost_container.visible = false

func _get_action_type(action: Action) -> String:
	if action is BuildingAction: return "BUILDING"
	elif action is TerrainAction: return "TERRAIN"
	else: return "default"

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		emit_signal("action_card_clicked")
