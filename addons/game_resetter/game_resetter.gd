@tool
extends EditorPlugin

var button

func _enter_tree():
	button = preload("res://addons/game_resetter/reset.tscn").instantiate()
	button.get_child(0).connect("button_up", button_clicked)
	#add_control_to_dock(EditorPlugin.DOCK_SLOT_LEFT_UL, button)
	add_control_to_container(EditorPlugin.CONTAINER_CANVAS_EDITOR_MENU, button)
	pass

func button_clicked():
	delete_level_info()
	pass
func delete_level_info():
	var dir = Directory.new()
	var file = File.new()
	if file.file_exists(GameConstants.LevelFileName):
		dir.open("user://")
		dir.remove(GameConstants.LevelFileName)
	else:
		print("File does not exists")

func _exit_tree():
	# Clean-up of the plugin goes here.
	pass
