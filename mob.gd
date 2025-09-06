extends Area2D

# In main the chain link means instance
# Called when the node enters the scene tree for the first time.
var velocity: Vector2 = Vector2.ZERO

@export var speed = 300 # Pixels per second

func start(spawn_pos: Vector2, direction: float, spd: float) -> void:
	global_position = spawn_pos
	rotation = direction
	speed = spd
	velocity = Vector2.RIGHT.rotated(direction) * speed
	# Ensuring that the explosion animation isnt picked
	var frames = Array($AnimatedSprite2D.sprite_frames.get_animation_names())
	if frames.has("explode"):
		frames.erase("explode")
	var mob_types = frames
	$AnimatedSprite2D.animation = mob_types.pick_random()
	$AnimatedSprite2D.play() # The expression GD.Randi() % n selects a random integer between 0 and n-1.

func _process(delta: float) -> void:
	if $AnimatedSprite2D.animation != "explode":
		global_position += velocity * delta
		
func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	queue_free()


func take_damage() -> void:
	if $AnimatedSprite2D.animation == "explode": return
	#Stopping collisions
	
	$CollisionShape2D.set_deferred("disabled", true)
	$AnimatedSprite2D.play("explode")


func _on_body_entered(body: Node2D) -> void:
	if $AnimatedSprite2D.animation == "explode": return
	if body.is_in_group("bullets"):
		_explode()


func _on_area_entered(area: Area2D) -> void:
	if $AnimatedSprite2D.animation == "explode": return
	
	if area.is_in_group("bullets"):
		_explode()

func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation == "explode":
		queue_free()

func _explode() -> void:
	set_deferred("monitoring", false) #stop overlaps
	$CollisionShape2D.set_deferred("disabled", true)
	velocity = Vector2.ZERO
	
	if $AnimatedSprite2D.animation == "explode":
		$AnimatedSprite2D.play("explode")
		await $AnimatedSprite2D.animation_finished
		
	queue_free()		
