extends Animal

signal explode(happiness_amoung:float)

@export var exploded = false
@export var timeTillDeath: float = 0
@export var timeSinceLastCollide: float = 0
@export var lastCollidedNode: Node3D

# Called when the node enters the scene tree for the first time.
func _ready():
	set_contact_monitor(true)
	set_max_contacts_reported(10000)
	body_entered.connect(_collide)
	#apply_impulse(Vector3(randf_range(-5,5),0,randf_range(-5,5)))



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	timeSinceLastCollide+=delta
	
	if (exploded):
		if (timeTillDeath > 2):
			queue_free()
		timeTillDeath += delta


func _collide(node):
	
	if (timeSinceLastCollide < 0.3 || (lastCollidedNode && lastCollidedNode == node)):
		lastCollidedNode = null
		return
	
	timeSinceLastCollide = 0
	lastCollidedNode = node
	
	explode.emit(happinessIncrease)
	
	if (life == 1):
		exploded = true
	else:
		_decrease_life()

