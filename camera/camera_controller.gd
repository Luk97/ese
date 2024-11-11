extends Camera2D

const MIN_ZOOM =0.3
const MAX_ZOOM = 5.0

var zoom_speed = 0.1
var move_speed = 600

func _ready() -> void:
	zoom = Vector2(5.0, 5.0)
	
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

func get_center() -> Vector2:
	return get_target_position()
	
func get_visible_area() -> Vector2:
	var area = get_viewport_rect()
	var scaled_area = Vector2(area.size.x / zoom.x, area.size.y / zoom.y)
	return scaled_area

func center_view(global_coords: Vector2) -> void:
	global_position = global_coords
