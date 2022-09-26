extends Node2D


func _ready():
	var file = File.new()
	if file.file_exists(GameConstants.LevelFileName) != true:
		print("file does not exists")
		file.open(GameConstants.LevelFileName, File.WRITE)
		file.store_line("1")
		print("File created")
		file.close()
	else:
		file.open(GameConstants.LevelFileName, File.READ)
		var level_number_read = file.get_as_text().to_int()
		GameConstants.CurrentLevel = level_number_read
		file.close()
		#print("Current level: " + str(GameConstants.CurrentLevel))
	#file.flush()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_play_button_up():
	get_tree().change_scene_to_file("res://scenes/main/game/game.tscn")
	pass # Replace with function body.
