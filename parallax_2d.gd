extends Parallax2D

@export var scroll_factor = -0.2
@export var player_path: NodePath
var player: Area2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_node(player_path)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#Manually adjust parallax to follow Player
	#pass
	print(player_path)
	print(player)
	if player:
		scroll_offset = player.global_position * scroll_factor
