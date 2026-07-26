extends Control

@export var burnedMatch = Sprite2D
@export var freshMatch = Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func match_burn():
	# Normalisera sprite storlek till 128px
	#scale = start_scale * 0.3
	var tween = create_tween()
	#tween.tween_property(StickMask, "value", 0, 10)
	#tween.tween_property(match, "position", Vector2(0,-140), 12).as_relative()
	tween.tween_property(freshMatch, "position",Vector2(0,-400),6).as_relative()
	tween.set_parallel()
	tween.tween_property(burnedMatch, "position",Vector2(0,-400),6).as_relative()
	#tween.tween_property(burnedMatch, "position",Vector2(0,-150),5).as_relative()
	
	print("Match Burning")
	print(freshMatch.position)
	print(burnedMatch.position)
		#.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	#tween.tween_property(self, "scale", Vector2.ZERO, pop_duration)\
	#	.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN)
	#global_scale = Vector2(0.1,0.1)
#	tween.tween_property(self, "scale", Vector2(0.5,0.5), 1.2)
	#tween.tween_callback(queue_free)
	#print("Bubble spawned")
