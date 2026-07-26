extends Line2D

@export var max_points = 5
@export var bubble_speed = 20.0
#@onready var character: CharacterBody2D = get_parent()

const POINT_INTERVAL = 0.1
const SPREAD = 6.0

var timer := 0.0 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	clear_points()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer -= delta
	if timer <= 0.0:
		timer = POINT_INTERVAL
		var offset = Vector2(randf_range(-SPREAD, SPREAD), randf_range(-SPREAD,SPREAD))
		add_point(get_parent().global_position + offset)
		if get_point_count() > max_points:
			remove_point(0)
	## 1. Add a new bubble point at the character's current global position
	#add_point(get_parent().global_position)
	##if points.size() > 30:
	##	remove_point(0)
	#
	## 2. Make every existing bubble drift upwards
	## This creates the top-down illusion of bubbles floating toward the water surface
	#for i in range(points.size()):
		#var current_pos = points[i]
		#current_pos.y -= bubble_speed * delta # Negative Y moves up in 2D
		#set_point_position(i, current_pos)
	#
	## 3. Maintain the trail length by removing the oldest point
	#if points.size() > max_points:
		#remove_point(0)
