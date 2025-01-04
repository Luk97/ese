class_name ActionSelection
extends CanvasLayer

@onready var action_card_1: ActionCard = %ActionCard1
@onready var action_card_2: ActionCard = %ActionCard2
@onready var action_card_3: ActionCard = %ActionCard3

signal action_selected(action: Action)

var action_1: Action
var action_2: Action
var action_3: Action

func set_action_selection_content(action_1: Action, action_2: Action, action_3: Action) -> void:
	self.action_1 = action_1
	self.action_2 = action_2
	self.action_3 = action_3
	action_card_1.set_content(action_1)
	action_card_2.set_content(action_2)
	action_card_3.set_content(action_3)

func _on_action_card_1_action_card_clicked() -> void:
	emit_signal("action_selected", action_1)

func _on_action_card_2_action_card_clicked() -> void:
	emit_signal("action_selected", action_2)

func _on_action_card_3_action_card_clicked() -> void:
	emit_signal("action_selected", action_3)
