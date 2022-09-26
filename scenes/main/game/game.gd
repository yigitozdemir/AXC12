extends Node2D

@export var sword_handler: Node2D
@export var current_level: int
var level = null
var current_step = -1
func _ready():
	current_level = GameConstants.CurrentLevel
	print("started level is: " + str(current_level))
	level = ResourceLoader.load("res://Levels/Level_"+str(current_level)+".res") as Level
	refresh_label()
	tick_level()

func refresh_label():
	if level.target_knives == 0:
		get_tree().change_scene_to_file("res://scenes/main/next_level/next_level.tscn")
		#print("level completed")
	$label_knives.text = str(level.target_knives)

func game_over():
	get_tree().change_scene_to_file("res://scenes/main/game_over/game_over.tscn")
	pass
	
func tick_level():
	if current_step == level.level_actions.size() -1:
		current_step = 0
	else:
		current_step += 1
	$LevelTimer.start(level.level_actions[current_step]["time"])
	$center.rotation_speed = level.level_actions[current_step]["rotation"]
	
func _process(delta):
	pass

func _input(event):
	if event.is_action_released("click"):
		var sword = sword_handler.get_child(0)
		sword.set("thrown", true)
		pass


func _on_level_timer_timeout():
	tick_level()
	pass # Replace with function body.
