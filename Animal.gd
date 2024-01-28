extends RigidBody3D

class_name Animal

@export var happinessIncrease: float
@export var life: float


func _decrease_life():
	life -= 1
	if (life == 0):
		queue_free()


func _increase_meeple_happiness(value, meeple):

	if (meeple.has_method("change_happiness")):
		meeple.change_happiness(value);
		return true
	return false
