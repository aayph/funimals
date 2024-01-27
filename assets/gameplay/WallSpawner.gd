extends Spawner

# Called when the node enters the scene tree for the first time.
func _ready():
	spawnOrigin = transform.origin + transform.basis.z
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super._process(delta)
	pass
