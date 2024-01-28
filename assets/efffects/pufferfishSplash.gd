extends MeshInstance3D

var explode = false
var explodeTimer = 0
var surfaceOverrideMaterial

# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent_node_3d().get_parent_node_3d().explode.connect(_explode)
	surfaceOverrideMaterial = get_surface_override_material(0) as ShaderMaterial


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (explode):
		explodeTimer += delta
		if (explodeTimer < 0.7):
			(surfaceOverrideMaterial).set_shader_parameter("FloatParameter", explodeTimer)
		else:
			(surfaceOverrideMaterial).set_shader_parameter("FloatParameter", 0)
			explode = false
			visible = false
			explodeTimer = 0



func _explode(_happinessIncrease):
	visible = true
	explode = true
