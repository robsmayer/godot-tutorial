extends Node

@export var mob_scene: PackedScene
var score

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


func game_over():
	$Music.stop()
	$DeathSound.play()
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	$Player.set_process(false)           # <- blocks movement & shooting

func new_game():
	$DeathSound.stop()
	$Music.play()
	get_tree().call_group("mobs", "queue_free")
	score = 0
	$Player.start($StartPosition.position)
	$Player.set_process(true)            # <- allow again
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	
func _on_score_timer_timeout():
	score += 1
	$HUD.update_score(score)

func _on_start_timer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()

func _on_mob_timer_timeout():
	# Creating instance of mob scene
	var mob = mob_scene.instantiate()
	
	# Random location for mob spawning
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()
	
	# Setting mob init position
	var mob_position = mob_spawn_location.position
	# Set mob's direction perpendicular to
	# the path direction
	# Add some randomness to the direction
	
	var mob_direction = mob_spawn_location.rotation + PI/2
	mob_direction +=  randf_range(-PI / 4, PI / 4) 
	
	var speed = randf_range(150.0,250.0)
	
	add_child(mob) #Add mob to main scene
	mob.start(mob_position,mob_direction,speed)
	
	
	
	
	
	
	
	
	
	
