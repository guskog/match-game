extends Area2D

signal hit
signal burned_out
signal about_to_burn_out

@export var speed = 400 # How fast player is
var screen_size # Size of game window
@export var match_container: Control
@export var match = Sprite2D



const BUBBLE_SCENE = preload("res://bubble.tscn")
var timer := 0.1
const SPAWN_INTERVAL = 0.15
var is_active := true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	# pass # Replace with function body.
	#hide()
	print(BUBBLE_SCENE)
	match_container.match_burn()
	match_container.burned_out.connect(_on_match_burned_out)
	match_container.about_to_burn_out.connect(_on_match_about_to_burn_out)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# pass
	if not is_active:
		return

	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y +=1
	#timer -= delta	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$Node2D/AnimatedSprite2D.animation = "up"
		$Node2D/AnimatedSprite2D.rotation = velocity.angle() + deg_to_rad(90)
		$Node2D/MatchContainer.rotation = velocity.angle() + deg_to_rad(90)
		#$Node2D/AnimatedSprite2D.play()
		$Node2D/AnimatedSprite2D.play()
		timer -= delta
		if timer <= 0.0:
			timer = SPAWN_INTERVAL
			spawn_bubble()
	#else:
	#	$AnimatedSprite2D.stop()
		
	position += velocity * delta
	position = position.clamp(Vector2.ZERO,screen_size)
	
	#if velocity.length() > 0:
	
	#timer -= delta
	#if timer <= 0.0:
		#timer = SPAWN_INTERVAL
		#spawn_bubble()
		
		
	
	#
	#if velocity.x != 0:
		#$AnimatedSprite2D.animation = "walk"
		##$AnimatedSprite2D.flip_v = false
		#
		## Note i docs, shorthand
		##$AnimatedSprite2D.flip_h = velocity.x < 0
	#elif velocity.y != 0:
		#$AnimatedSprite2D.animation = "up"
		#$AnimatedSprite2D.flip_v = velocity.y > 0
		#
func _on_match_about_to_burn_out() -> void:
	about_to_burn_out.emit()

func _on_match_burned_out() -> void:
	is_active = false
	$CollisionShape2D.set_deferred("disabled", true)
	# Call function to extinguish flame
	#$AnimatedSprite2D.hide()
	add_to_group("burned_matches")
	
	# Flytta match container utanför eld
	match_container.reparent(self, true)
	
	# Släck elden
	var tween = create_tween()
	tween.set_parallel()
	tween.tween_property($Node2D/AnimatedSprite2D, "modulate:a", 0, 2)
	tween.tween_property($Node2D/AnimatedSprite2D, "scale", Vector2(0.3,0.3), 1)
	
	burned_out.emit()

func _on_body_entered(_body: Node2D) -> void:
	#pass # Replace with function body.
	#hide()
	is_active = false
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)
	
	
func start(pos):
	position = pos
	is_active = true
	show()
	$Node2D/AnimatedSprite2D.rotation = randf_range(0, TAU)
	$CollisionShape2D.disabled = false
	if has_node("Camera2D"):
		$Camera2D.enabled = true
		$Camera2D.reset_smoothing()
	
func spawn_bubble():
	var bubble = BUBBLE_SCENE.instantiate()
	bubble.start_scale = $Node2D/AnimatedSprite2D.scale * 0.7 # SCale the 32px sprite to good size
	get_tree().current_scene.add_child(bubble)
	bubble.global_position = global_position + Vector2(randf_range(-14,14), randf_range(-14,14))
#	bubble.scale = Vector2(1,1)*0.5# * randf_range(0.14,0.26)

func throw_from(start_pos: Vector2, target_pos: Vector2, duration: float = 0.7, arc_height: float = 200.0) ->void:
	is_active = false
	position = start_pos
	show()
	$CollisionShape2D.disabled = true
	
	# Här kan kamera params vara
	#if has_node("Camera2D"):
	#	$Camera2D.enabled = false
	
	var tween = create_tween()
	#rotation = -100
	#tween.tween_property($AnimatedSprite2D, "position", Vector2(0,100),2).as_relative()
	tween.set_parallel(true)
	
	tween.tween_method(
		func(t): _update_throw_position(t, start_pos, target_pos, arc_height), 
		0.0, 1.0, duration
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	
	tween.tween_property($Node2D/AnimatedSprite2D, "rotation", TAU * 1, duration).as_relative()
	
	tween.chain().tween_callback(func(): start(target_pos))
	
func _update_throw_position(t: float, from: Vector2, to: Vector2, arc_height: float) -> void:
	var pos = from.lerp(to, t)
	pos.y -= sin(t*PI) * arc_height
	position = pos
		
	
	
	
	
	
	
	
	
	
	
	
