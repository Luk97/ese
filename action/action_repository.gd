class_name ActionRepository
extends Node

# Action.new(
#    Id,
#    Type,
#    Title,
#    Description,
#    Texture,
#    Building (optional)
# )

var catalog: Array[Action] = [
	BuildingAction.new(
		Constants.ACTION_ID_BUILD_HOME,
		"Build new Home",
		"Slows down the need for warmth.",
		load("res://assets/action/Home-Icon.png"),
		Home.new()
	),
	BuildingAction.new(
		Constants.ACTION_ID_BUILD_WOOOD_CUTTER,
		"Build new Wood Cutter",
		"Produces one wood every two rounds.",
		load("res://assets/action/Woodcutter-Icon.png"),
		WoodCutter.new()
	),
	BuildingAction.new(
		Constants.ACTION_ID_BUILD_OUTPOST,
		"Build new Outpost",
		"Has a large view radius to scout the surroundings.",
		load("res://assets/tiles/overlay/on_land/on_grass/outpost.png"),
		Outpost.new()
	),
	BuildingAction.new(
		Constants.ACTION_ID_BUILD_BURNER,
		"Build new Burner",
		"Placeholder Description",
		load("res://assets/tiles/overlay/on_land/on_grass/burner.png"),
		Burner.new()
	),
	BuildingAction.new(
		Constants.ACTION_ID_BUILD_FARM,
		"Build new Farm",
		"Placeholder Description",
		load("res://assets/tiles/overlay/on_land/on_grass/Farm.png"),
		Farm.new()
	),
	BuildingAction.new(
		Constants.ACTION_ID_BUILD_FIELD,
		"Build new Field",
		"Placeholder Description",
		load("res://assets/tiles/overlay/on_land/on_grass/Field.png"),
		Field.new()
	),
	BuildingAction.new(
		Constants.ACTION_ID_BUILD_WINDMILL,
		"Build new Windmill",
		"Placeholder Description",
		load("res://assets/tiles/overlay/on_land/on_grass/windmill.png"),
		Windmill.new()
	),
	BuildingAction.new(
		Constants.ACTION_ID_BUILD_QUARRY,
		"Build new Quarry",
		"Placeholder Description",
		load("res://assets/tiles/overlay/on_land/on_grass/windmill.png"),
		Quarry.new()
	),
	TerrainAction.new(
		Constants.ACTION_ID_CLEAR_FOREST,
		"Clear forest",
		"Clear a forest tile from all trees receiving 10 wood in the process.",
		load("res://assets/action/axe.png"),
		[Types.TileType.FOREST, Types.TileType.DEEP_FOREST],
		Types.TileType.GRASS,
		{ Types.ResourceType.WOOD: 10 },
		0, Vector2i(9, 9)
	),
	TerrainAction.new(
		Constants.ACTION_ID_CLEAR_MOUNTAIN,
		"Clear mountain",
		"Clear a mountain tile from all stones receiving 10 stone in the process.",
		load("res://assets/action/Bomb.png"),	
		[Types.TileType.MOUNTAIN, Types.TileType.TALL_MOUNTAIN],
		Types.TileType.GRASS,
		{ Types.ResourceType.STONE: 10 },
		1, Vector2i(0, 0)
	)
]

var starter_pool: Array[Action] = [
	_find_action_by_id(Constants.ACTION_ID_BUILD_HOME),
	_find_action_by_id(Constants.ACTION_ID_BUILD_WOOOD_CUTTER),
	_find_action_by_id(Constants.ACTION_ID_BUILD_OUTPOST),
	_find_action_by_id(Constants.ACTION_ID_BUILD_BURNER),
	_find_action_by_id(Constants.ACTION_ID_BUILD_FARM),
	_find_action_by_id(Constants.ACTION_ID_BUILD_FIELD),
	_find_action_by_id(Constants.ACTION_ID_BUILD_WINDMILL),
	_find_action_by_id(Constants.ACTION_ID_BUILD_QUARRY),
	_find_action_by_id(Constants.ACTION_ID_CLEAR_FOREST),
	_find_action_by_id(Constants.ACTION_ID_CLEAR_MOUNTAIN)
]

var pool = starter_pool


func get_starter_action() -> Action:
	return _find_action_by_id(Constants.ACTION_ID_BUILD_HOME)

func get_random_selection_from_pool() -> Array:
	var pool_copy = pool.duplicate()
	var action_1 = pool_copy.pick_random()
	pool_copy.erase(action_1)
	var action_2 = pool_copy.pick_random()
	pool_copy.erase(action_2)
	var action_3 = pool_copy.pick_random()
	return [action_1, action_2, action_3]

func _find_action_by_id(id: String) -> Action:
	for action in catalog:
		if action.id == id:
			return action
	return null
