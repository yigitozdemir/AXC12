extends Node2D


func _on_button_button_up():
	GameConstants.CurrentLevel += 1
	var file = File.new()
	file.open(GameConstants.LevelFileName, File.WRITE_READ)
	file.store_line(str(GameConstants.CurrentLevel))
	get_tree().change_scene_to_file("res://scenes/main/game/game.tscn")
	pass


func _on_button_reset_level_info_button_up():
	var directory = Directory.new()
	if directory.open("res://Levels") == OK:
		directory.list_dir_begin()
		var file_name = directory.get_next()
		while file_name != "":
			directory.remove(file_name)
			file_name = directory.get_next()
	print("Levels Cleared")
	get_tree().change_scene_to_file("res://scenes/main/game/game.tscn")
