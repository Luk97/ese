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
	fontsScale()
	action_card_design.size=Vector2(size.x*scaleCardInside,size.y*scaleCardInside)
	action_card_design.set_position(Vector2(action_card_design.position.x,position.y+0.1*size.y))
	var sizing=action_card_design.size.y/scalingPicture
	picture.size=Vector2(sizing,sizing)
	picture.set_position(Vector2(action_card_design.position.x,0))

func fontsScale()->void:
	var titleFontSize = min(action_card_design.size.x / fontScaleXTitle, action_card_design.size.y / fontScaleYTitle)
	title.add_theme_font_size_override("font_size",titleFontSize)
	var fontScaleXubtitle = min(action_card_design.size.x / fontScaleXSubtitle, action_card_design.size.y / fontScaleYSubtitle)
	type.add_theme_font_size_override("font_size",fontScaleXubtitle)
	var textFontSize = min(action_card_design.size.x / fontScaleXText, action_card_design.size.y / fontScaleYText)
	description.add_theme_font_size_override("font_size",textFontSize)
	cost.add_theme_font_size_override("font_size",textFontSize)

func signal_clicked_emit() -> void:
	emit_signal("action_card_clicked")


func _on_picture_picture_clicked() -> void:
	signal_clicked_emit()


func _on_picture_box_picture_clicked() -> void:
	signal_clicked_emit()
