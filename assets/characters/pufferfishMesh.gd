extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent_node_3d().explode.connect(_explode)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _explode():
	queue_free()
