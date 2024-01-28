extends MeshInstance3D

var squidSplatter
var squid
var materialOverride
var shaderParameter: float = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	squidSplatter = get_parent_node_3d().get_parent_node_3d().get_parent_node_3d()
	squid = squidSplatter.get_parent_node_3d()
	squid.splatter.connect(_activate)
	materialOverride = get_surface_override_material(0) as ShaderMaterial
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (visible):
		shaderParameter -= delta
		if (shaderParameter>-0.8):
			materialOverride.set_shader_parameter("FloatParameter", shaderParameter)
			materialOverride.set_shader_parameter("FloatParameter2", shaderParameter)
		if (shaderParameter < -2):
			(materialOverride).set_shader_parameter("FloatParameter", 0)
			squid.queue_free()


func _activate():
	visible = true
	squid.splatter.disconnect(_activate)


