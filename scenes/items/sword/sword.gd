extends Area2D

@export var thrown: bool
@export var speed: float

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if thrown:
		position.y += speed
	pass


func _on_sword_area_entered(area: Area2D):
	if area.collision_layer == 2:
		get_parent().get_parent().game_over()
	if area.name == "center":
		get_parent().call("spawn")
		get_parent().get_parent().level.target_knives -= 1
		get_parent().get_parent().refresh_label()
		var _prevPos = global_position;
		thrown = false
		get_parent().remove_child(self)
		area.add_child(self)
		monitoring = false
		global_rotation = 0
		global_position = _prevPos
		z_index = -1
	pass # Replace with function body.
