extends Node3D

@export var child_axis: Node3D

@export var min_pos: Vector3
@export var max_pos: Vector3
@export var camera_speed: float = 1.0
@export var rotate_speed: float = 1.0
@export var sensitivity: float = 1.0

var _mouse_mode: int = 0
var _mouse_position = Vector2(0.0, 0.0)

func _process(delta):
	var x = Input.get_axis("camera_left", "camera_right")
	var z = Input.get_axis("camera_front", "camera_back")
	var r = Input.get_axis("rotate_left", "rotate_right")
	translate(Vector3(x, 0.0, z) * camera_speed * delta)
	transform.origin = transform.origin.clamp(min_pos, max_pos)
	rotate(Vector3.UP, r * rotate_speed * delta)
	_update_mouselook()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		_mouse_position = event.relative

	if event is InputEventMouseButton:
		match event.button_index:
			MOUSE_BUTTON_RIGHT: # Only allows rotation if right click down
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED if event.pressed else Input.MOUSE_MODE_VISIBLE)
				_mouse_mode = 1
			MOUSE_BUTTON_MIDDLE:
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED if event.pressed else Input.MOUSE_MODE_VISIBLE)
				_mouse_mode = 2

func _update_mouselook():
	# Only rotates mouse if the mouse is captured
	if Input.get_mouse_mode() != Input.MOUSE_MODE_CAPTURED:
		return

	if _mouse_mode == 1:
		_mouse_position *= sensitivity
		var yaw = _mouse_position.x
		var pitch = _mouse_position.y
		_mouse_position = Vector2(0, 0)

		rotate(Vector3.UP, deg_to_rad(-yaw))
		child_axis.rotate(Vector3(1,0,0), deg_to_rad(-pitch))

	if _mouse_mode == 2:
		_mouse_position *= sensitivity
		translate(Vector3(-_mouse_position.x, 0.0, -_mouse_position.y))
		transform.origin = transform.origin.clamp(min_pos, max_pos)
		_mouse_position = Vector2(0, 0)
