extends CollisionShape3D


# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent_node_3d().explode.connect(_enable)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _enable():
	disabled = false
