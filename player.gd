extends Area2D

signal hit

@export var speed = 400 # Pixels per second
#Using the export keyword on the first variable speed allows us to set its value in the Inspector. 

var screensize
# Called when the node enters the scene tree for the first time.
func _ready():
	screensize = get_viewport_rect().size
	# hide()
	
#_process() function to define what the player will do. _process()
# is called every frame, so we'll use it to update elements of our game, which we expect will change often
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity = Vector2.ZERO #Player movement vector
	
	if Input.is_action_pressed("up"):
		velocity.y -= 1
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if Input.is_action_pressed("left"): # To the left to the left
		velocity.x -= 1 # Everything u own in the box to the left
	if Input.is_action_pressed("right"):
		velocity.x += 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play() # $something is short for get node of something
	else:
		$AnimatedSprite2D.stop()
		
	position += velocity * delta # Delta parameter refers to frame length ensuring 
	position = position.clamp(Vector2.ZERO, screensize) # consistent movement with frame change
	
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = velocity.y > 0


func _on_body_entered(body: Node2D) -> void:
	hide()
	hit.emit()
	# Must be deferred as we can't change physics properties on a physics callback.
	$CollisionShape2D.set_deferred("disabled", true)
	
#we can call to reset the player when starting a new game
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
	
	
	
	
