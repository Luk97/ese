class_name ActionRepository
extends Node

# Action.new(
#    Id,
#    Type,
#    Title,
#    Description,
#    Texture
# )

var catalog: Array[Action] = [
	BuildingAction.new(
		Constants.ACTION_ID_BUILD_HOME,
		"Build new Home",
		"Does this even do anything?",
		load("res://assets/action/Home-Icon.png"),
		Home.new()
	),
	BuildingAction.new(
		Constants.ACTION_ID_BUILD_WOOOD_CUTTER,
		"Build new Wood Cutter",
		"Produces 3 wood every 2 rounds.",
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
		"Produces 4 wood every 2 rounds.",
		load("res://assets/tiles/overlay/on_land/on_grass/burner.png"),
		Burner.new()
	),
	BuildingAction.new(
		Constants.ACTION_ID_BUILD_FARM,
		"Build new Farm",
		"Produces 5 food every 4 rounds.",
		load("res://assets/tiles/overlay/on_land/on_grass/Farm.png"),
		Farm.new()
	),
	BuildingAction.new(
		Constants.ACTION_ID_BUILD_FIELD,
		"Build new Field",
		"Produces 1 food every 2 rounds.",
		load("res://assets/tiles/overlay/on_land/on_grass/Field.png"),
		Field.new()
	),
	BuildingAction.new(
		Constants.ACTION_ID_BUILD_WINDMILL,
		"Build new Windmill",
		"Produces 4 food every 3 rounds.",
		load("res://assets/tiles/overlay/on_land/on_grass/windmill.png"),
		Windmill.new()
	),
	BuildingAction.new(
		Constants.ACTION_ID_BUILD_QUARRY,
		"Build new Quarry",
		"Produces 3 stone every 2 rounds.",
		load("res://assets/tiles/overlay/on_land/on_grass/Quarry.png"),
		Quarry.new()
	),
	BuildingAction.new(
		Constants.ACTION_ID_BUILD_BUOY,
		"Build new Buoy",
		"Place on water to scout the surroundings.",
		load("res://assets/tiles/overlay/on_water/buoy.png"),
		Buoy.new()
	),
	BuildingAction.new(
		Constants.ACTION_ID_BUILD_FISHERBOAT,
		"Build new Fisherboat",
		"Produces 1 food every 2 rounds.",
		load("res://assets/tiles/overlay/on_water/fisherboat.png"),
		Fisherboat.new()
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
		0, Vector2i(8, 9)
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
	_find_action_by_id(Constants.ACTION_ID_BUILD_BUOY),
	_find_action_by_id(Constants.ACTION_ID_BUILD_FISHERBOAT),
	_find_action_by_id(Constants.ACTION_ID_CLEAR_FOREST),
	_find_action_by_id(Constants.ACTION_ID_CLEAR_MOUNTAIN)
]

var pool = starter_pool


func get_starter_action() -> Action:
	return _find_action_by_id(Constants.ACTION_ID_BUILD_HOME)

func get_random_selection_from_pool() -> Array:
	var action_selection: Array = []
	var viable_pool: Array = _get_viable_actions()
	for i in range(0, 3):
		if not viable_pool.is_empty():
			var action = viable_pool.pick_random()
			action_selection.append(action)
			viable_pool.erase(action)
	return action_selection

func _get_viable_actions() -> Array:
	var actions: Array[Action] = []
	for action: Action in self.pool:
		if ActionExecutor.check_for_existing_tile(action):
			actions.append(action)
	return actions

func _find_action_by_id(id: String) -> Action:
	for action in catalog:
		if action.id == id:
			return action
	return null
