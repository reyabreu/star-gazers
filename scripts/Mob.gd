extends Area2D

export (int) var min_speed # minimum speed range
export (int) var max_speed # maximum speed range

onready var animated_sprite = $AnimatedSprite

var speed
var last_y

func _ready():
	speed = min_speed
	last_y = position.y
	animated_sprite.play("eat")

func _process(delta):
	position.y += speed * delta
	if abs(position.y - last_y) > 100:
		last_y = position.y
		print("mob [%d] y position is: %d" % [get_instance_id(), position.y])

func set_speed(new_speed):
	speed = clamp(new_speed, min_speed, max_speed)

func _on_Viisibility_screen_exited():
	queue_free()
	print("mob [%d] has been killed" % get_instance_id())