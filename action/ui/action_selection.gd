class_name ActionSelection
extends CanvasLayer

@onready var action_card_1: ActionCard = %ActionCard1
@onready var action_card_2: ActionCard = %ActionCard2
@onready var action_card_3: ActionCard = %ActionCard3

signal action_selected(action: Action)

var action_1: Action
var action_2: Action
var action_3: Action

func set_action_selection_content(actions: Array) -> void:
	if actions.size() > 0:
		self.action_1 = actions[0]
		self.action_card_1.visible = true
		self.action_card_1.set_content(actions[0])
	else:
		action_card_1.visible = false
	
	if actions.size() > 1:
		self.action_2 = actions[1]
		self.action_card_2.visible = true
		self.action_card_2.set_content(actions[1])
	else:
		action_card_2.visible = false
	
	if actions.size() > 2:
		self.action_3 = actions[2]
		self.action_card_3.visible = true
		self.action_card_3.set_content(actions[2])
	else:
		action_card_3.visible = false


func _on_action_card_1_action_card_clicked() -> void:
	emit_signal("action_selected", action_1)

func _on_action_card_2_action_card_clicked() -> void:
	emit_signal("action_selected", action_2)

func _on_action_card_3_action_card_clicked() -> void:
	emit_signal("action_selected", action_3)
