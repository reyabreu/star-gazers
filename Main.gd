extends Node

onready var player = $Player
onready var start_position = $Position2D  

func _ready():
	player.position = start_position.position