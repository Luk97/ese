class_name ActionCard
extends NinePatchRect

@onready var action_manager: ActionManager = %ActionManager
@onready var title: Label = %Title
@onready var description: Label = %Description
@onready var cost: Label = %Cost
@onready var cost_container: HBoxContainer = %CostContainer
@onready var type: Label = %Type
@onready var action_card_design: NinePatchRect = %ActionCardDesign
@onready var picture: TextureRect = %Picture

signal action_card_clicked()

var fontScaleXTitle=20
var fontScaleYTitle=20
var fontScaleXText=40
var fontScaleYText=40

func set_content(action: Action) -> void:
	title.text = action.title
	type.text = _get_action_type(action)
	description.text = action.description
	picture.texture = action.texture
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

func _process(delta: float) -> void:
	var titleFontSize = min(get_window().size.x / fontScaleXTitle, get_window().size.y / fontScaleYTitle)
	title.add_theme_font_size_override("font_size",titleFontSize)
	var textFontSize = min(get_window().size.x / fontScaleXText, get_window().size.y / fontScaleYText)
	type.add_theme_font_size_override("font_size",textFontSize)
	description.add_theme_font_size_override("font_size",textFontSize)
	cost.add_theme_font_size_override("font_size",textFontSize)

func signal_clicked_emit() -> void:
	emit_signal("action_card_clicked")


func _on_picture_picture_clicked() -> void:
	signal_clicked_emit()
