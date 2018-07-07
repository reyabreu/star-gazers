extends Node

export (PackedScene) var mob

onready var player = $Player
onready var start_position = $Position2D  
onready var mob_spawn_location = $MobPath/MobSpawnLocation
onready var mob_timer = $MobTimer
onready var hud = $HUD

func _ready():
	randomize()

func _on_MobTimer_timeout():
	mob_spawn_location.set_offset(randi())
	var new_mob =  mob.instance()
	new_mob.set_scale(Vector2(0.15, 0.15))
	new_mob.position = mob_spawn_location.position
	var new_speed = rand_range(new_mob.min_speed, new_mob.max_speed)
	new_mob.set_speed(new_speed)
	add_child(new_mob)
	print("mob [%d] created at: %s with speed %d" % [new_mob.get_instance_id(), new_mob.position, new_speed])

func new_simulation():
	player.start(start_position.position)
	mob_timer.start()
	hud.show_message("simulation starting...")

func simulation_end():
	mob_timer.stop()
	hud.show_simulation_end()
