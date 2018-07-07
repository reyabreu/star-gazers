extends Area2D

signal player_hit

const MARGIN = 5
export (int) var speed = 250

onready var sprite = $Sprite
onready var collision_shape = $CollisionShape2D

var opened_eye = preload("res://sprites/star-gazwer-openeye.png")
var closed_eye = preload("res://sprites/star-gazwer-closedeye.png")

var player_half_width
var screen_width

func _ready():
	screen_width = get_viewport_rect().size.x
	player_half_width = (sprite.texture.get_width()*scale.x)/2

func _process(delta):
	if Input.is_action_pressed("ui_up"):
		sprite.set_texture(opened_eye)
	elif Input.is_action_pressed("ui_down"):
		sprite.set_texture(closed_eye)
	
	var velocity = Vector2()
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		sprite.flip_h = velocity.x < 0
		position += velocity * delta
		position.x = clamp(position.x, MARGIN + player_half_width, screen_width - player_half_width)

func start(start_position):
	position = start_position
	show()
	collision_shape.disabled = false

func _on_Player_area_entered(area):
	collision_shape.disabled = true
	hide()
	print("player has been killed")
	emit_signal("player_hit")
