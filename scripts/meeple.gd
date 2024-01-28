extends CharacterBody3D
class_name Meeple

@export var area: Area3D
@export var direction_update_period_min: float = 1.0
@export var direction_update_period_max: float = 2.0
@export var reduction_per_second: float = 1.0/60.0
@export var base_happiness:float = 0.5
@export var speed:float = 4.0
@export var emoji: PackedScene

var happiness: float
var timer: float

var forced_direction: Vector3
var wanted_direction: Vector3

var is_meeple = true

func change_happiness(happiness_change: float, affect_money: bool = true) -> float:
	var old_happiness := happiness
	if affect_money:
		confetti(roundi(happiness_change * 11.0))
	happiness += happiness_change
	happiness = clamp(happiness, -1.0, 1.0)
	for c in get_children():
		if c.has_method("set_happiness"):
			c.set_happiness(happiness)
	Gamestate.meeple_happiness_changed.emit(self, happiness-old_happiness, affect_money)
	return happiness

const confetti_force = 10
func confetti(amount: int = 1):
	for n in amount:
		var confett = emoji.instantiate()
		add_child(confett)
		confett.apply_force(Vector3(randf()-0.5, 2.0, randf()-0.5) * confetti_force)

func _ready() -> void:
	Gamestate.change_state.connect(_on_state_change)

func _on_state_change(new_state: Gamestate.StateChange):
	match new_state:
		Gamestate.StateChange.LEVEL_START:
			Gamestate.register_meeple(self)
			init()

func init():
	change_happiness(base_happiness, false)
	timer = randf_range(direction_update_period_min, direction_update_period_max)
	var close_objects := area.get_overlapping_bodies()
	forced_direction = get_forced_direction(close_objects)
	wanted_direction = Vector3(randf_range(-1.0, 1.0), 0.0, randf_range(-1.0, 1.0)).normalized()

func _process(delta: float) -> void:
	timer -= delta
	if happiness >= base_happiness:
		change_happiness(-reduction_per_second * delta, false)
	else:
		change_happiness(reduction_per_second * delta, false)
	if timer <= 0:
		if Gamestate.current_state == Gamestate.StateChange.LEVEL_WIN:
			confetti()

		timer += randf_range(direction_update_period_min, direction_update_period_max)
		var close_objects := area.get_overlapping_bodies()
		forced_direction = get_forced_direction(close_objects)
		wanted_direction = Vector3(clampf(wanted_direction.x + randf_range(-1.0, 1.0) * 0.8, -0.5, 0.5),
		 0, clampf(wanted_direction.z + randf_range(-1.0, 1.0) * 0.8, -0.5, 0.5))
		look_at(forced_direction + wanted_direction + transform.origin)


func _physics_process(_delta: float) -> void:
	velocity = (forced_direction + wanted_direction + Vector3(randf_range(-1.0, 1.0), 0.0, randf_range(-1.0, 1.0)) * 0.2) * speed
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
