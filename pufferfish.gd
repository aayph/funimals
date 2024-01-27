extends Animal

signal explode()

var exploded = false
var timeTillDeath: float = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	set_contact_monitor(true)
	set_max_contacts_reported(10)
	body_entered.connect(_collide)
	life = 3
	happinessIncrease = 0.3
	#apply_impulse(Vector3(randf_range(-5,5),0,randf_range(-5,5)))
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (exploded):
		if (timeTillDeath > 2):
			queue_free()
		timeTillDeath += delta
		

func _collide(node):
	
	_increase_meeple_happiness(happinessIncrease, node)
	
	if (life == 1):
		gravity_scale = 0
		explode.emit()
	else:
		_decrease_life()

