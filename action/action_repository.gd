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
	Action.new(
		Constants.ACTION_ID_BUILD_HOME,
		Types.ActionType.BUILD_NEW_BUILDING,
		"Build new Home",
		"Placeholder Description",
		load("res://assets/action/Home-Icon.png"),
		Home.new()
	),
	Action.new(
		Constants.ACTION_ID_BUILD_WOOOD_CUTTER,
		Types.ActionType.BUILD_NEW_BUILDING,
		"Build new Wood Cutter",
		"Placeholder Description",
		load("res://assets/action/Woodcutter-Icon.png"),
		WoodCutter.new()
	),
	Action.new(
		Constants.ACTION_ID_BUILD_OUTPOST,
		Types.ActionType.BUILD_NEW_BUILDING,
		"Build new Outpost",
		"Placeholder Description",
		load("res://assets/tiles/overlay/on_land/on_grass/outpost.png"),
		Outpost.new()
	)
]

var starter_pool: Array[Action] = [
	_find_action_by_id(Constants.ACTION_ID_BUILD_HOME),
	_find_action_by_id(Constants.ACTION_ID_BUILD_WOOOD_CUTTER),
	_find_action_by_id(Constants.ACTION_ID_BUILD_OUTPOST)
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
