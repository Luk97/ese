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

var fontScaleXTitle=10
var fontScaleYTitle=10
var fontScaleXSubtitle=15
var fontScaleYSubtitle=15
var fontScaleXText=20
var fontScaleYText=20
var scaleCardInside=0.8

func set_content(action: Action) -> void:
	title.text = action.title
	type.text = str(action.type)
	description.text = action.description
	picture.texture = action.texture
	if action.type == Types.ActionType.BUILD_NEW_BUILDING:
		cost_container.visible = true
		cost.text = str(action.building.cost)
	else:
		cost_container.visible = false


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		emit_signal("action_card_clicked")

func _process(delta: float) -> void:
	var titleFontSize = min(get_window().size.x / fontScaleXTitle, get_window().size.y / fontScaleYTitle)
	title.add_theme_font_size_override("font_size",titleFontSize)
	var fontScaleXubtitle = min(get_window().size.x / fontScaleXSubtitle, get_window().size.y / fontScaleYSubtitle)
	type.add_theme_font_size_override("font_size",fontScaleXubtitle)
	var textFontSize = min(get_window().size.x / fontScaleXText, get_window().size.y / fontScaleYText)
	description.add_theme_font_size_override("font_size",textFontSize)
	cost.add_theme_font_size_override("font_size",textFontSize)
	action_card_design.size=Vector2(size.x*scaleCardInside,size.y*scaleCardInside)

func signal_clicked_emit() -> void:
	emit_signal("action_card_clicked")


func _on_picture_picture_clicked() -> void:
	signal_clicked_emit()


func _on_picture_box_picture_clicked() -> void:
	signal_clicked_emit()


func _on_karten_rahmen_picture_clicked() -> void:
	signal_clicked_emit()
