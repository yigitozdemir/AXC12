extends Node2D

@export var sword_scene_path: String
var loaded_sword_scene = null
# Called when the node enters the scene tree for the first time.
func _ready():
	loaded_sword_scene = load(sword_scene_path)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func spawn():
	var instance = loaded_sword_scene.instantiate()
	add_child(instance)
