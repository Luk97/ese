extends Camera2D

const MIN_ZOOM = 0.1
const MAX_ZOOM = 3.0

var zoom_speed = 0.1
var move_speed = 300

func _ready() -> void:
	zoom = Vector2(0.5, 0.5)
	
func _process(delta):
	if Input.is_action_pressed("ui_left"):
		global_position += Vector2.LEFT * delta * move_speed
	elif Input.is_action_pressed("ui_right"):
		global_position += Vector2.RIGHT * delta * move_speed
	elif Input.is_action_pressed("ui_up"):
		global_position += Vector2.UP * delta * move_speed
	elif Input.is_action_pressed("ui_down"):
		global_position += Vector2.DOWN * delta * move_speed
	
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
			zoom_out()
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.pressed:
			zoom_in()

func zoom_in():
	var new_zoom = zoom - Vector2(zoom_speed, zoom_speed)
	zoom = Vector2(
		clamp(new_zoom.x, MIN_ZOOM, MAX_ZOOM),
		clamp(new_zoom.y, MIN_ZOOM, MAX_ZOOM)
	)

func zoom_out():
	var new_zoom = zoom + Vector2(zoom_speed, zoom_speed)
	zoom = Vector2(
		clamp(new_zoom.x, MIN_ZOOM, MAX_ZOOM),
		clamp(new_zoom.y, MIN_ZOOM, MAX_ZOOM)
	)
	
func getMousePosition() -> Vector2:
	return get_viewport().get_mouse_position()
	
func get_visible_tile_area(tile_size: Vector2) -> Rect2:
	var screen_size = get_viewport().size
	var scaled_screen_size = Vector2(screen_size.x / zoom.x, screen_size.y / zoom.y)

	var top_left_world = global_position - Vector2(scaled_screen_size.x / 2, scaled_screen_size.y / 2)
	var bottom_right_world = global_position + Vector2(scaled_screen_size.x * zoom.x / 2, scaled_screen_size.y * zoom.y / 2)

	var top_left_tile = top_left_world / tile_size
	var bottom_right_tile = bottom_right_world / tile_size
	
	return Rect2(top_left_tile, bottom_right_tile - top_left_tile)
