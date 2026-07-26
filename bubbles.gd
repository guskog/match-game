extends Sprite2D

@export var start_scale: Vector2 = Vector2(1,1) #Overwritten by spawn_bubble
@export var grow_scale: float = 1.3
@export var grow_duration: float = 0.8
@export var pop_duration: float = 0.15

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Normalisera sprite storlek till 128px
	scale = start_scale * 0.3
	var tween = create_tween()
	tween.tween_property(self, "scale", start_scale * grow_scale, grow_duration)\
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	#tween.set_parallel()
	tween.parallel().tween_property(self, "modulate:a", 0.5, grow_duration)
	tween.tween_property(self, "scale", Vector2.ZERO, pop_duration)\
		.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN)
	#global_scale = Vector2(0.1,0.1)
#	tween.tween_property(self, "scale", Vector2(0.5,0.5), 1.2)
	tween.tween_callback(queue_free)
	#print("Bubble spawned")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
