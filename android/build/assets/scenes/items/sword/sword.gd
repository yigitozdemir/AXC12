extends Area2D

@export var thrown: bool
@export var speed: float
signal on_sword_hit_center
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _enter_tree():
	if get_parent().get_name() != StringName("welcome"):
		connect("on_sword_hit_center", get_parent().get_parent()._on_sword_on_sword_hit_center)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if thrown:
		position.y += speed
	pass


func _on_sword_area_entered(area: Area2D):
	if area.collision_layer == 2:
		get_parent().get_parent().game_over()
	if area.collision_layer == 1:
		#disconnect("on_sword_hit_center", get_parent().get_parent()._on_sword_on_sword_hit_center())
		
		var _prevPos = global_position;
		thrown = false
		get_parent().remove_child(self)
		area.add_child(self)
		monitoring = false
		global_rotation = 0
		global_position = _prevPos
		z_index = -1
		emit_signal("on_sword_hit_center")
	pass # Replace with function body.
