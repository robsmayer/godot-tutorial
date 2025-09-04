extends Area2D

@export var speed = 400 # Pixels per second
#Using the export keyword on the first variable speed allows us to set its value in the Inspector. 

var screensize
# Called when the node enters the scene tree for the first time.
func _ready():
	screensize = get_viewport_rect().size
	pass # Replace with function body.

#_process() function to define what the player will do. _process()
# is called every frame, so we'll use it to update elements of our game, which we expect will change often
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
