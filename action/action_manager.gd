class_name ActionManager
extends Node2D

signal action_selected(action: Action)

@export var pool: Dictionary = {}

@onready var action_selection: ActionSelection = %ActionSelection
@onready var building_manager: BuildingManager = %BuildingManager
@onready var rng: RandomNumberGenerator

const NAME = "name"
const TYPE = "type"
const DESCRIPTION = "description"
const IMAGE_PATH = "image_path"
const BUILDING_NAME = "building_name"
const TERRAIN_ORIGINS = "terrain_origins"
const TERRAIN_DESTINATION = "terrain_destination"
const TERRAIN_SOURCE_ID = "terrain_source_id"
const TERRAIN_ATLAS_COORDS = "terrain_atlas_coords"

var total_actions: Dictionary = {
	"headquarter": {
		NAME: "Headquarter",
		TYPE: BuildingAction,
		DESCRIPTION: "This does nothing yet.",
		IMAGE_PATH: "res://assets/action/Home-Icon.png" ,
		BUILDING_NAME: Building.Type.headquarter
	},
	"wood_cutter": {
		NAME: "Wood Cutter",
		TYPE: BuildingAction,
		DESCRIPTION: "This produces wood each round.",
		IMAGE_PATH: "res://assets/action/Woodcutter-Icon.png",
		BUILDING_NAME: Building.Type.wood_cutter
	},
	"grub_forest": {
		NAME: "Grub Forest",
		TYPE: TerrainAction,
		DESCRIPTION: "Remove one forest tile. It becomes a grass tile.",
		IMAGE_PATH: "res://assets/action/axe.png",
		TERRAIN_ORIGINS: [ForestTile],
		TERRAIN_DESTINATION: [GrassTile],
		TERRAIN_SOURCE_ID: 3,
		TERRAIN_ATLAS_COORDS: Vector2i(0, 0)
	}
}


#=================== PUBLIC FUNCTIONS ===================

func get_starter_action() -> Action:
	return _get_building_action("headquarter")

func start_action_selection() -> void:
	action_selection.visible = true
	var actions = _get_random_action_selection()
	action_selection.set_action_selection_content(actions[0], actions[1], actions[2])


#=================== PRIVATE FUNCTIONS ===================

func _ready() -> void:
	_initialize_action_pool()
	action_selection.visible = false
	rng = RandomNumberGenerator.new()
	rng.randomize()

func _initialize_action_pool():
	pool["headquarter"] = total_actions["headquarter"]
	pool["wood_cutter"] = total_actions["wood_cutter"]
	pool["grub_forest"] = total_actions["grub_forest"]

func _on_action_selection_action_selected(action: Action) -> void:
	action_selection.visible = false
	emit_signal("action_selected", action)

func _get_action(name: String) -> Action:
	if pool[name][TYPE] == BuildingAction:
		return _get_building_action(name)
	elif pool[name][TYPE] == TerrainAction:
		return _get_terrain_action(name)
	return null

func _get_building_action(name: String) -> BuildingAction:
	if pool.has(name):
		var building = building_manager.create_building(pool[name][BUILDING_NAME])
		if building == null:
			return null
		return BuildingAction.new(
			pool[name][DESCRIPTION],
			pool[name][IMAGE_PATH],
			building
		)
	return null

func _get_terrain_action(name: String) -> TerrainAction:
	if pool.has(name):
		return TerrainAction.new(
			pool[name][NAME],
			pool[name][DESCRIPTION],
			pool[name][IMAGE_PATH],
			pool[name][TERRAIN_ORIGINS],
			pool[name][TERRAIN_DESTINATION],
			pool[name][TERRAIN_SOURCE_ID],
			pool[name][TERRAIN_ATLAS_COORDS]
		)
	return null

func _get_random_action_selection() -> Array:
	var pool_copy = pool.duplicate()
	var actions: Array = []
	for i in range(3):
		var random_key = pool_copy.keys().pick_random()
		var action = _get_action(random_key)
		actions.append(action)
		pool_copy.erase(random_key)
	return actions
