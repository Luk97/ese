extends Camera2D

const MIN_ZOOM = 0.5
const MAX_ZOOM = 3.0

var zoom_speed = 0.1

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
	
func getGlobalPosition() -> Vector2:
	return get_viewport().get_camera_2d().global_position
