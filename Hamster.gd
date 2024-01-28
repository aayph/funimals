extends Animal

signal change_facing(FacingVector)

@export var SPEED = 300.0
var xDirection: float = randf_range(-1, 1)
var zDirection: float = randf_range(-1, 1)
var lastCollision
var collidedOnce = false

func _ready():
	set_contact_monitor(true)
	set_max_contacts_reported(10)
	change_facing.emit(Vector3(xDirection, 0, zDirection).normalized())
	body_entered.connect(_change_direction)


func _physics_process(_delta):
	set_inertia(Vector3(1000, 10000, 10000))


func _change_direction(node):

	if (!collidedOnce):
		collidedOnce = true
		return;

	if (!_increase_meeple_happiness(happinessIncrease, node)):
		_decrease_life()

	change_facing.emit(Vector3(xDirection, 0, zDirection).normalized())

	#print(global_basis.x.angle_to(node.global_basis.x))
	#print(xDirection)
	#print(zDirection)
	var angle = global_basis.x.normalized().angle_to(node.global_basis.x.normalized())
	if (xDirection > 0 && zDirection > 0):
		if (angle>1.7):
			zDirection = (zDirection * -1) + randf_range(-0.1, -5 * sign(zDirection))
		else:
			xDirection = (xDirection * -1) + randf_range(-0.1, -5 * sign(xDirection))


	else: if (xDirection < 0 && zDirection < 0):
		if (angle<1.55):
			zDirection = (zDirection * -1) + randf_range(-0.1, -5 * sign(zDirection))
		else:
			xDirection = (xDirection * -1) + randf_range(-0.1, -5 * sign(xDirection))

	else: if (xDirection < 0 && zDirection > 0):
		if (angle>1.6):
			zDirection = (zDirection * -1) + randf_range(-0.1, -5 * sign(zDirection))
		else:
			xDirection = (xDirection * -1) + randf_range(-0.1, -5 * sign(xDirection))


	else: if (xDirection > 0 && zDirection < 0):
		if (angle<1.55):
			zDirection = (zDirection * -1) + randf_range(-0.1, -5 * sign(zDirection))
		else:
			xDirection = (xDirection * -1) + randf_range(-0.1, -5 * sign(xDirection))

	apply_force(Vector3(xDirection, 0, zDirection).normalized() * SPEED)
