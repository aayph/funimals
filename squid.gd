extends Animal

signal splatter()

@export var timer: float = 0
@export var timeTillNextDash: float
@export var speed: float = 1000
@export var splatterCount: float = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	_splatter()
	timeTillNextDash = randf_range(1,2)
	body_entered.connect(_collision)

func _process(delta):
	get_node("Mesh/squid").rotate(Vector3(0,1,0), 10)
	timer += delta
	if (timer > timeTillNextDash):
		timer = 0
		timeTillNextDash = randf_range(1,2)
		apply_force(speed * Vector3(randf_range(-1, 1), randf_range(-1, 0), randf_range(-1, 1)).normalized() )
		
		_decrease_life()
		_splatter()

func _collision(node):
	pass

func _splatter():
	var newSquidSplatter = load("res://squidSplatter.tscn")
	var scene_instance = newSquidSplatter.instantiate()
	scene_instance.set_name("SquidSplatter".insert(0, "%.0f" % splatterCount))
	add_child(scene_instance)
	splatter.emit()
