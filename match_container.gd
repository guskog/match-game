extends Control

signal burned_out
signal about_to_burn_out

@export var burnedMatch = Sprite2D
@export var freshMatch = Sprite2D
@export var fire_sprite = AnimatedSprite2D
@export var burn_duration := 6.0
@export var throw_lead_time := 0.2

var burn_tween: Tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#var tween = create_tween()
	#tween.tween_property()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func match_burn():
	# Normalisera sprite storlek till 128px
	#scale = start_scale * 0.3
	burn_tween = create_tween()
	#tween.tween_property(StickMask, "value", 0, 10)
	#tween.tween_property(match, "position", Vector2(0,-140), 12).as_relative()
	burn_tween.tween_property(freshMatch, "position",Vector2(0,-400),burn_duration).as_relative()
	#tween.set_parallel()
	burn_tween.parallel().tween_property(burnedMatch, "position",Vector2(0,-400),burn_duration).as_relative()
	#tween.tween_property(burnedMatch, "position",Vector2(0,-150),5).as_relative()
	
	var lead_tween = create_tween()
	lead_tween.tween_interval(burn_duration - throw_lead_time)
	lead_tween.tween_callback(func(): about_to_burn_out.emit())
	
	burn_tween.tween_callback(func(): burned_out.emit())
	#print("Match Burning")
	#print(freshMatch.position)
	#print(burnedMatch.position)
		#.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	#tween.tween_property(self, "scale", Vector2.ZERO, pop_duration)\
	#	.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN)
	#global_scale = Vector2(0.1,0.1)
#	tween.tween_property(self, "scale", Vector2(0.5,0.5), 1.2)
	#tween.tween_callback(queue_free)
	#print("Bubble spawned")

func match_extinguish(new_parent: Node)->void:
	# Stoppa animationen av sticka
	if burn_tween and burn_tween.is_valid():
		burn_tween.kill()
		add_to_group("burned_matches")
	# Flytta match container utanför eld
	self.reparent(new_parent, true)
	
	# Släck elden
	var tween = create_tween()
	tween.set_parallel()
	tween.tween_property(fire_sprite, "modulate:a", 0, 2)
	tween.tween_property(fire_sprite, "scale", Vector2(0.3,0.3), 1)
	
	

	
	
