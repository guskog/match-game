extends CharacterBody2D

@export var toad_position: Vector2 = Vector2(480,250)
#var new_position = $AnimatedSprite2D.position + Vector2(-20,0)
@export var hop_duration = 0.5
@export var hop_length = 80
#var start_position

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#var mob_types = Array($AnimatedSprite2D.sprite_frames.get_animation_names())
	#$AnimatedSprite2D.animation
	$AnimatedSprite2D.play("frog_idle")
	global_position = toad_position
	#$AnimatedSprite2D.global_position = toad_position
	hop_loop()
	
	#$AnimatedSprite2D.play()
	#for looper in range (5):
		
		
		
		#var new_position = $AnimatedSprite2D.position
		#toad_move(new_position + Vector2(0,-30))
	#	toad_move($AnimatedSprite2D.position + Vector2(0,-30))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func hop_loop():
	while global_position.x > 20:
		var target_position = global_position + Vector2(-hop_length,0)
		await toad_move(target_position)
		await get_tree().create_timer(2).timeout
	print("Toad on left side")
		
func toad_move(new_position):
	#var new_position = Vector2(250,500)
	# Funktionen tar ny position som toad ska flytta sig till
	# På nuvarande toad position toad.currentposition
		# Rotera mot ny position
			# Vector currentPosition -> NewPosition
			# Vector length = 1
			# toad.rotate = vector
		# Flytta till ny position över tid (använd tween?)
	#$AnimatedSprite2D.create_tween()
	#$AnimatedSprite2D.frame = 1
	#$AnimatedSprite2D.pause()
	#$AnimatedSprite2D.speed_scale = 1
	#var tween = $AnimatedSprite2D.create_tween()
	var frame_count = $AnimatedSprite2D.sprite_frames.get_frame_count("frog_jump")
	$AnimatedSprite2D.play("frog_jump")
	var tween = create_tween()
	tween.EASE_OUT
	tween.TRANS_SINE
	
	tween.tween_method(
		func(t):
			global_position = toad_position.lerp(new_position, t)
			var f = int (t * frame_count)
			$AnimatedSprite2D.frame = clamp(f, 0, frame_count - 1), 0, 1.0, hop_duration
	)
	#tween.tween_property(self, "global_position", new_position, 1)
	#tween.tween_property(self, "global_position", new_position, .1)
	await tween.finished
	#$AnimatedSprite2D.frame = 0
	#$AnimatedSprite2D.flip_h
	$AnimatedSprite2D.play("frog_idle")
	toad_position = global_position
	#if !tween.is_running():
	
	#$AnimatedSprite2D.stop()
			# var tween = create_tween()
			# moveTime = vector_currentToNew.length / moveSpeed
			# tween.tween_property(self, "position", newPosition, moveTime) 
	#$AnimatedSprite2D.play()
	#$AnimatedSprite2D.frame = 0
	#$AnimatedSprite2D.pause()
	#tween.tween_property(self, "global_position", new_position, 1)
	
	
	# toad.currentposition = toad.position
