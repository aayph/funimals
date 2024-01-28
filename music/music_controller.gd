extends Node
@export var stream_a: AudioStreamPlayer
@export var a_min_db: float = -10.0
@export var a_max_db: float = 0.0
@export var a_min_progress: float = 0.0
@export var a_max_progress: float = 0.6

@export var stream_b: AudioStreamPlayer
@export var b_min_db: float = -30.0
@export var b_max_db: float = 0.0
@export var b_min_progress: float = 0.0
@export var b_max_progress: float = 0.8

@export var stream_c: AudioStreamPlayer
@export var c_min_db: float = -40.0
@export var c_max_db: float = 0.0
@export var c_min_progress: float = 0.2
@export var c_max_progress: float = 1.0

@export var min_pitch: float = 0.8
@export var max_pitch: float = 1.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Gamestate.total_happiness_changed.connect(_on_happiness_changed)


func _on_happiness_changed(_total_happiness):
	var progress: float = Gamestate.get_relative_win_happiness()


	stream_a.volume_db = lerpf(a_min_db, a_max_db,
		clampf((progress - a_min_progress) / (a_max_progress - a_min_progress), 0.0, 1.0))
	stream_b.volume_db = lerpf(b_min_db, b_max_db,
		clampf((progress - b_min_progress) / (b_max_progress - b_min_progress), 0.0, 1.0))
	stream_c.volume_db = lerpf(c_min_db, c_max_db,
		clampf((progress - c_min_progress) / (c_max_progress - c_min_progress), 0.0, 1.0))

	var pitch = max_pitch - min_pitch
	stream_a.pitch_scale = clampf(min_pitch + pitch * progress, 0.8, 1.0)
	stream_b.pitch_scale = clampf(min_pitch + pitch * progress, 0.8, 1.0)
	stream_c.pitch_scale = clampf(min_pitch + pitch * progress, 0.8, 1.0)


func _on_level_1_finished() -> void:
	stream_a.play()
	stream_b.play()
	stream_c.play()
