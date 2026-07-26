extends Camera2D

@export var camera_limit_padding = 60

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	limit_left = -camera_limit_padding
	limit_top = -camera_limit_padding
	limit_right = 480+camera_limit_padding
	limit_bottom = 720+camera_limit_padding
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
