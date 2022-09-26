extends Node2D

@export var level_count: int = 10
@export var count_text: TextEdit

@export_category("Rotation Speed")
@export var min_rotation_speed: float = 1.0
@export var max_rotation_speed: float = 5.0
@export_category("Step Count")
@export var min_step_count: int = 2
@export var max_step_count: int = 5
@export_category("Time")
@export var min_time:float = 1.0
@export var max_time:float = 4.0
@export_category("Target Knives")
@export var min_knives: int = 5
@export var max_knives: int = 6

func _on_button_button_up():
	level_count = count_text.text.to_int()
	var current_level: int = 0
	var test_data1 = Dictionary()
	var test_data2 = Dictionary()
	randomize()
	var step_count = randi_range(min_step_count, max_step_count)
	
	while current_level < level_count:
		randomize()
		step_count = randi_range(min_step_count, max_step_count)
		randomize()
		var level = Level.new()
		level.target_knives = randi_range(min_knives, max_knives)
		level.level_number = current_level+1
		level.current_step = 0
		level.level_actions = Array()
		
		var current_step = 0
		while current_step < step_count:
			var data = {}
			randomize()
			data["time"] = randf_range(min_time, max_time)
			randomize()
			data["rotation"] = randf_range(min_rotation_speed, max_rotation_speed) * random_multiplier()
			level.level_actions.append(data)
			current_step += 1
		var err = ResourceSaver.save(level, "res://Levels/Level_"+str(current_level+1)+ ".res")
		if err != OK:
			print("couldn't save")
		current_level += 1

func random_multiplier() ->int:
	randomize()
	if randf() < 0.5:
		return 1
	else:
		return -1
		
func _on_clear_levels_button_button_up():
	var directory = Directory.new()
	if directory.open("res://Levels") == OK:
		directory.list_dir_begin()
		var file_name = directory.get_next()
		while file_name != "":
			directory.remove(file_name)
			file_name = directory.get_next()
	print("Levels Cleared")
