extends Node

@export var mob_scene: PackedScene
@export var mob_toad_scene: PackedScene
@export var player_scene: PackedScene
@onready var matchbox_position: Marker2D = $MatchboxPosition

var score = 1
var highScore = 0
var current_player: Area2D
var is_game_active := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#new_game()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func game_over() -> void:
	#pass # Replace with function body.
	$ScoreTimer.stop()
	$MobTimer.stop()
	#$ToadTimer.stop()
	$HUD.show_game_over()
	$Music.stop()
	$DeathSound.play()
	is_game_active = false

	
func new_game():
	# Clear previous game
	#player.queue_free()
	print(get_tree().get_nodes_in_group("burned_matches"))
	get_tree().call_group("mobs", "queue_free")
	get_tree().call_group("burned_matches", "queue_free")
	score = 0
	#$Player.start($StartPosition.position)
	is_game_active = true
	spawn_player($StartPosition.position)
	$StartTimer.start()
	$HUD.updateScore(score)
	$HUD.show_message("Get Ready")
	$Music.play()
	

func spawn_player(pos: Vector2) ->void:
	if not is_game_active:
		return
	var new_player = player_scene.instantiate()
	add_child(new_player)
	new_player.throw_from(matchbox_position.position, pos)
	new_player.about_to_burn_out.connect(_on_player_about_to_burn_out)
	#new_player.start(pos)
	new_player.burned_out.connect(_on_player_burned_out)
	new_player.hit.connect(game_over)
	current_player = new_player

func _on_player_about_to_burn_out() -> void:
	var spawn_pos = current_player.position
	spawn_player(spawn_pos)

func _on_player_burned_out() -> void:
	pass
	#print("Burned out reached")


func _on_mob_timer_timeout() -> void:
	#pass # Replace with function body.
	var mob = mob_scene.instantiate()
	# Choose a random location on Path2D.
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()
	
	# Set the mob's position to the random location.
	mob.position = mob_spawn_location.position
	
	
	# Set the mob's direction perpendicular to the path direction.
	var direction = mob_spawn_location.rotation + PI / 2
	
	
	# Add some randomness to the direction.
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction 
	
# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
		
	# Spawn the mob by adding it to the Main scene.
	add_child(mob)

func _on_toad_timer_timeout() -> void:
	print("Toad timer")
	var mob_toad = mob_toad_scene.instantiate()
	add_child(mob_toad)
	
func _on_score_timer_timeout() -> void:
#	pass # Replace with function body.
	score += 1
	$HUD.updateScore(score)
	if score > highScore:
		highScore = score
		$HUD.updateHighscore(highScore)


func _on_start_timer_timeout() -> void:
	#pass # Replace with function body.
	$MobTimer.start()
	#$ToadTimer.start()
	$ScoreTimer.start()
	
