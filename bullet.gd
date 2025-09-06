extends Area2D

@export var direction: Vector2 = Vector2.UP
@export var speed: float = 800.0


func _ready():
	add_to_group("Bullets", true)
	
func _process(delta: float) -> void:
	global_position += direction * speed * delta
	if !get_viewport_rect().has_point(global_position):
		queue_free()

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("mobs"):
		if body.has_method("take_damage"):
			body.take_damage()
		_destroy()

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("mobs"):
		if area.has_method("take_damage"):
			area.take_damage()
		_destroy()

func _destroy() -> void:
	set_deferred("monitoring", false) # stop further hits immediately
	hide()
	queue_free()
