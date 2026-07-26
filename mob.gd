extends RigidBody2D

#@export var fall_height := 300.0
@export var fall_duration := 0.6
@export var start_scale_factor := 1.8
var is_falling := true

var has_fallen_off := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void: # Ska det vara void eller inte??
	var mob_types = Array($AnimatedSprite2D.sprite_frames.get_animation_names())
	$AnimatedSprite2D.animation = "ice"  #mob_types.pick_random()
	$AnimatedSprite2D.play() 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _physics_process(_delta: float) -> void:
	if is_falling or has_fallen_off:
		return
	if not get_parent().is_inside_platform(global_position):
		fall_off_edge()
	

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	#pass # Replace with function body.
	queue_free()

func spawn_falling(start_pos: Vector2, landing_pos: Vector2, final_velocity: Vector2) -> void:
	is_falling = true
	freeze = true
	linear_velocity = Vector2.ZERO
	if has_node("CollisionShape2D"):
		$CollisionShape2D.set_deferred("disabled", true)
	
	global_position = start_pos
	scale = Vector2.ONE * start_scale_factor
	modulate.a = 0.6
	
	
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "global_position", landing_pos, fall_duration)
	
	tween.tween_property(self, "scale", Vector2.ONE, fall_duration)
	
	tween.tween_property(self, "modulate:a", 1.0, fall_duration)
	
	tween.chain().tween_callback(func():_on_landed(final_velocity))
	
	
func _on_landed(final_velocity: Vector2)-> void:
	is_falling = false
	if has_node("CollisionShape2D"):
		$CollisionShape2D.set_deferred("disabled", false)
	freeze = false
	linear_velocity = final_velocity
	
func fall_off_edge()-> void:
	#print("Falling off edge")
	has_fallen_off = true
	freeze = true
	if has_node("CollisionShape2D"):
		$CollisionShape2D.set_deferred("disabled", true)
	
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "scale", Vector2.ZERO, fall_duration)
	tween.tween_property(self, "modulate:a", 0, fall_duration)
	tween.chain().tween_callback(queue_free)
	
