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
@export var max_knives: int = 14

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


func _on_button_clear_game_data_button_up():
	var dir = Directory.new()
	var file = File.new()
	
	if file.file_exists(GameConstants.LevelFileName):
		dir.open("user://")
		dir.remove(GameConstants.LevelFileName)
	else:
		print("File does not exists")


func _on_button_2_button_up():
	var i = 0
	while i < get_node("TextEdit").text.to_int():
		order_levels()
		i += 1
		if i % 10 == 0:
			print("Iteration: " + str(i))
	display_order_final_result()

func order_levels():
	var directory = Directory.new()
	var root_folder = "res://Levels/"
	if directory.open("res://Levels") == OK:
		directory.list_dir_begin()
		var previous_file_name = directory.get_next()
		var file_name = directory.get_next()
		while file_name != "":
			#print("Previous file name: " + previous_file_name)
			#print("File name: " + file_name)
			var previous_level = ResourceLoader.load(root_folder + previous_file_name) as Level
			var level = ResourceLoader.load(root_folder + file_name) as Level
			if level.target_knives < previous_level.target_knives:
				directory.rename(previous_file_name, "tmp.res")
				directory.rename(file_name, previous_file_name)
				directory.rename("tmp.res", file_name)
			
			previous_file_name = file_name
			file_name = directory.get_next()
	pass

func display_order_final_result():
	var directory = Directory.new()
	var root_folder = "res://Levels/"
	if directory.open("res://Levels") == OK:
		directory.list_dir_begin()
		var file_name = directory.get_next()
		while file_name != "":
			#print("Previous file name: " + previous_file_name)
			#print("File name: " + file_name)
			var level = ResourceLoader.load(root_folder + file_name) as Level
			print(file_name + " Target count: " + str(level.target_knives))
			file_name = directory.get_next()
	pass
