extends CanvasLayer

@onready var wood_label: NinePatchRect = %WoodLabel
@onready var wheat_label: NinePatchRect = %WheatLabel
@onready var stone_label: NinePatchRect = %StoneLabel
@onready var food_Progress: NinePatchRect = %food_Progress
@onready var heat_Progress: NinePatchRect = %heat_Progress
@onready var roundCounter: NinePatchRect = %RoundCounterLabel
@onready var topLeftMenu: Control = %TopLeftMenu

@onready var top_Interface_Container: VBoxContainer = %Top_Interface_Container
@onready var bottom_Interface_Container: VBoxContainer = %Bottom_Interface_Container



signal round_finished

func _ready() -> void:
	ResourceManager.wood_updated.connect(update_wood_label)
	ResourceManager.wheat_updated.connect(update_wheat_label)
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

func update_wheat_label(wheat: int) -> void:
	wheat_label.set_resource_count(wheat)

func update_food_Progress(food: int) -> void:
	food_Progress.setNewFoodValue(food)
	
func update_heat_Progress(heat: int) -> void:
	heat_Progress.setNewHeatValue(heat)

func _process(delta: float) -> void:
	scaling()

func scaling()->void:
		#top_Interface_Container.size.y=min(60,0.1*get_window().size.y) #noch unschoen
	roundCounter.size=Vector2(top_Interface_Container.size.x*0.1,top_Interface_Container.size.y);
	wood_label.size=Vector2(top_Interface_Container.size.x*0.075,top_Interface_Container.size.y);
	stone_label.size=Vector2(top_Interface_Container.size.x*0.075,top_Interface_Container.size.y);
	wheat_label.size=Vector2(top_Interface_Container.size.x*0.075,top_Interface_Container.size.y);
	
	var margin=top_Interface_Container.size.x*0.01
	roundCounter.position=Vector2(0,0)
	wood_label.position=Vector2(roundCounter.position.x+roundCounter.size.x+margin,0)
	stone_label.position=Vector2(wood_label.position.x+stone_label.size.x+margin,0)
	wheat_label.position=Vector2(stone_label.position.x+wheat_label.size.x+margin,0)
