extends CanvasLayer

@onready var wood_label: NinePatchRect = %WoodLabel
@onready var food_label: NinePatchRect = %FoodLabel
@onready var stone_label: NinePatchRect = %StoneLabel
@onready var roundCounter: NinePatchRect = %RoundCounterLabel
@onready var topLeftMenu: Control = %TopLeftMenu
@onready var menu: Button = %Menu
@onready var food_progress_bar: NinePatchRect = %foodProgressBar
@onready var heat_progress_bar: NinePatchRect = %heatProgressBar
@onready var newRound: Button = %RundeBeenden

@onready var top_Interface_Container: VBoxContainer = %Top_Interface_Container
@onready var bottom_Interface_Container: VBoxContainer = %Bottom_Interface_Container

var fontScale=1
var resourceLabelRatioXY=2
var roundLabelRatioXY=3

signal round_finished
signal game_over

func _ready() -> void:
	ResourceManager.wood_updated.connect(update_wood_label)
	ResourceManager.stone_updated.connect(update_stone_label)
	ResourceManager.food_updated.connect(update_food_label)
	scaling()

func showcase(startShowcase: bool) -> void:
	if(startShowcase):
		topLeftMenu.visible=false
		bottom_Interface_Container.visible=false
	else:
		topLeftMenu.visible=true
		bottom_Interface_Container.visible=true

func _on_finish_round_button_pressed() -> void:
	emit_signal("round_finished")

func update_wood_label(wood: int) -> void:
	wood_label.set_resource_count(wood)

func update_stone_label(stone: int) -> void:
	stone_label.set_resource_count(stone)

func update_food_label(wheat: int) -> void:
	food_label.set_resource_count(wheat)

func decrease_food_progress() -> void:
	food_progress_bar.decrease()
	
func decrease_warmth_progress() -> void:
	heat_progress_bar.decrease()

func increase_food_progress() -> void:
	food_progress_bar.increase()
	
func increase_warmth_progress() -> void:
	heat_progress_bar.increase()

func update_progress_bar_buttons() -> void:
	var food_cost = GameManager.get_food_increase_cost()
	food_progress_bar.setCost(food_cost)
	if food_cost > ResourceManager.get_food_count() or food_progress_bar.is_full():
		food_progress_bar.disable_button()
	else:
		food_progress_bar.enable_button()
	
	var warmth_cost = GameManager.get_warmth_increase_cost()
	heat_progress_bar.setCost(warmth_cost)
	if warmth_cost > ResourceManager.get_wood_count() or heat_progress_bar.is_full():
		heat_progress_bar.disable_button()
	else:
		heat_progress_bar.enable_button()


func _process(delta: float) -> void:
	update_progress_bar_buttons()
	scaling()

func scaling()->void:
	#Size Scaling
	var maxLabelTextLength=max(wood_label.get_Text_Length(),stone_label.get_Text_Length(),food_label.get_Text_Length())
	var roundLabelLength=roundCounter.get_Text_Length()
	top_Interface_Container.size.y=0.05*get_window().size.y
	roundCounter.size=Vector2(top_Interface_Container.size.y*roundLabelRatioXY,top_Interface_Container.size.y);
	wood_label.size=Vector2(top_Interface_Container.size.y*resourceLabelRatioXY,top_Interface_Container.size.y);
	stone_label.size=Vector2(top_Interface_Container.size.y*resourceLabelRatioXY,top_Interface_Container.size.y);
	food_label.size=Vector2(top_Interface_Container.size.y*resourceLabelRatioXY,top_Interface_Container.size.y);
	
	var margin=top_Interface_Container.size.x*0.01
	roundCounter.position=Vector2(0,0)
	wood_label.position=Vector2(roundCounter.position.x+roundCounter.size.x+margin,0)
	stone_label.position=Vector2(wood_label.position.x+stone_label.size.x+margin,0)
	food_label.position=Vector2(stone_label.position.x+food_label.size.x+margin,0)
	
	#FontSize
	var fontSize=fontScale*roundCounter.size.y
	roundCounter.setFontSize(fontSize)
	wood_label.setFontSize(fontSize)
	stone_label.setFontSize(fontSize)
	food_label.setFontSize(fontSize)
	menu.setFontSize(fontSize)

func _on_food_progress_bar_bar_empty() -> void:
	emit_signal("game_over")

func _on_heat_progress_bar_bar_empty() -> void:
	emit_signal("game_over")

func _on_food_progress_bar_bar_increased() -> void:
	update_progress_bar_buttons()

func _on_heat_progress_bar_bar_increased() -> void:
	update_progress_bar_buttons()

func enabelNextRound()->void:
	newRound.disabled=false
	
func disabelNextRound()->void:
	newRound.disabled=true
