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
		
		#get_tree().change_scene_to_file("res://scenes/main/next_level/next_level.tscn")

func render_next_level():
	get_tree().change_scene_to_file("res://scenes/main/next_level/next_level.tscn")
func start_crack_animation():
	#$center.queue_free()
	($center/AnimationPlayer as AnimationPlayer).play("crack")
	for child in $center.get_children():
		if child is Area2D:
			child.queue_free()
	pass

func refresh_label():
	$label_knives.text = str(level.target_knives)

func game_over():
	get_tree().change_scene_to_file("res://scenes/main/game_over/game_over.tscn")
	pass
	
func tick_level():
	if level.target_knives == 0:
		return
	if current_step == level.level_actions.size() -1:
		current_step = 0
	else:
		current_step += 1
	$LevelTimer.start(level.level_actions[current_step]["time"])
	$center.rotation_speed = level.level_actions[current_step]["rotation"]
	
func _process(delta):
	if level.target_knives == 0 and $LevelTimer:
		$LevelTimer.queue_free()
	pass

func _input(event):
	if event.is_action_released("click"):
		var sword = sword_handler.get_child(0)
		sword.set("thrown", true)
		pass


func _on_level_timer_timeout():
	tick_level()
	pass # Replace with function body.


func _on_sword_on_sword_hit_center():
	if level != null:
		if level.target_knives == 0:
			start_crack_animation()
