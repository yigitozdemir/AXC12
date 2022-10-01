extends Area2D

@export var rotation_speed: float

# Called when the node enters the scene tree for the first time.
func _ready():
	$C1.freeze = true
	$C2.freeze = true
	$C3.freeze = true
	pass # Replace with function body.

func _unfreeze():
	$C1.visible = true
	$C2.visible = true
	$C3.visible = true
	$C1.freeze = false
	$C2.freeze = false
	$C3.freeze = false
func next_level():
	get_parent().call("render_next_level")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotate(rotation_speed*delta)
	pass
