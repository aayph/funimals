extends CharacterBody3D
class_name Meeple

@export var area: Area3D
@export var direction_update_period_min = 1.0
@export var direction_update_period_max = 1.0
var happiness: float
var timer: float

var forced_direction: Vector3
var wanted_direction: Vector3


func change_happiness(happiness_change: float) -> float:
	var old_happiness := happiness
	happiness += happiness_change
	happiness = clamp(happiness, -1.0, 1.0)
	for c in get_children():
		if c.has_method("set_happiness"):
			c.set_happiness(happiness)
	Gamestate.meeple_happiness_changed.emit(self, happiness-old_happiness)
	return happiness

func _ready() -> void:
	timer = randf_range(direction_update_period_min, direction_update_period_max)
	var close_objects := area.get_overlapping_bodies()
	forced_direction = get_forced_direction(close_objects)
	wanted_direction = Vector3(randf_range(-1.0, 1.0), 0.0, randf_range(-1.0, 1.0)).normalized()

func _process(delta: float) -> void:
	timer -= delta
	if timer <= 0:
		timer += randf_range(direction_update_period_min, direction_update_period_max)
		var close_objects := area.get_overlapping_bodies()
		forced_direction = get_forced_direction(close_objects)
		wanted_direction = Vector3(clampf(wanted_direction.x + randf_range(-1.0, 1.0) * 0.8, -0.5, 0.5),
		 0, clampf(wanted_direction.z + randf_range(-1.0, 1.0) * 0.8, -0.5, 0.5))


func _physics_process(delta: float) -> void:
	velocity = forced_direction + wanted_direction + Vector3(randf_range(-1.0, 1.0), 0.0, randf_range(-1.0, 1.0)) * 0.2
	move_and_slide()

func get_forced_direction(objects: Array[Node3D]) -> Vector3:
	var direction := Vector3.ZERO
	for o in objects:
		for c in o.get_children():
			if c.has_method("get_repell_strength"):
				var strength = c.get_repell_strength(transform.origin, happiness)
				direction += transform.origin.direction_to(o.transform.origin) * strength
			if c.has_method("get_attraction_strength"):
				var strength = c.get_attraction_strength(transform.origin, happiness)
				direction -= transform.origin.direction_to(o.transform.origin) * strength

	direction.y = 0.0
	return direction
