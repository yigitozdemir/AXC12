extends Node2D


func _on_button_button_up():
	GameConstants.CurrentLevel += 1
	var file = File.new()
	file.open(GameConstants.LevelFileName, File.WRITE_READ)
	file.store_line(str(GameConstants.CurrentLevel))
	get_tree().change_scene_to_file("res://scenes/main/game/game.tscn")
	pass
