extends Camera2D

@export var movement_speed := 1.0
@export var threshold = 2.0

@export var zoom_speed = 0.05

var MIN_ZOOM = 2.0
var MAX_ZOOM = 6.0

var previous_position = Vector2()
var dragging = false

var start_position: Vector2
var current_time := 0.0
var moving = false

func _process(delta: float) -> void:
	if moving:
		current_time += delta
		var t = clamp(current_time / 2.0, 0, 1)
		global_position = start_position.lerp(Vector2(0, 0), ease_in_out(t))
		if t >= 1:
			moving = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_select"):
		start_position = global_position
		current_time = 0.0
		moving = true
	
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			dragging = event.pressed
			if dragging:
				previous_position = get_global_mouse_position()
		
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			zoom -= Vector2(zoom_speed, zoom_speed)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			zoom += Vector2(zoom_speed, zoom_speed)
		zoom = Vector2(clamp(zoom.x, MIN_ZOOM, MAX_ZOOM), clamp(zoom.y, MIN_ZOOM, MAX_ZOOM))
	
	elif event is InputEventMouseMotion and dragging:
		var curret_position = get_global_mouse_position()
		var delta = curret_position - previous_position
		if threshold < delta.length():
			position -= delta * movement_speed

func ease_in_out(t: float) -> float:
	return t * t * (3 - 2 * t)
