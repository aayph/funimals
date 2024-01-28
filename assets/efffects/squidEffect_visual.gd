extends MeshInstance3D

@export var squidSplatter: RigidBody3D
@export var squid: Animal
@export var materialOverride: ShaderMaterial
@export var shaderParameter: float = 1
@export var squidTrailFade: float = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	squidSplatter = get_parent_node_3d().get_parent_node_3d().get_parent_node_3d().get_parent_node_3d()
	squid = squidSplatter.get_parent_node_3d()
	squid.splatter.connect(_activate)
	materialOverride = get_surface_override_material(0) as ShaderMaterial
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (visible):
		shaderParameter -= delta
		squidTrailFade -= delta
		
		if (shaderParameter>-1):
			set_instance_shader_parameter("FloatParameter", shaderParameter)
			set_instance_shader_parameter("FloatParameter2", shaderParameter)
		#else:
			#set_instance_shader_parameter("FloatParameter", 1)
		if (squidTrailFade > -1):
			set_instance_shader_parameter("squidTrailFade", squidTrailFade)
		#else:
			#set_instance_shader_parameter("squidTrailFade", 1)
		if (shaderParameter < -2):
			squidSplatter.queue_free()
		



func _activate():
	visible = true
	squid.splatter.disconnect(_activate)


