extends Node
@export var min_time:float = 0.6
@export var max_time:float = 2.2
@export var nodes: Array[Node3D]

var time: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	nodes.pick_random().visible = true
	time = randf_range(min_time, max_time)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time-= delta
	if time <= 0.0:
		queue_free()
