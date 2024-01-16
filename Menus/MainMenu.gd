extends Control

var server_script = preload("res://Scripts/Server.gd");
var test_scene = preload("res://Scenes/Map/test_scene.tscn");

func _on_settings_pressed():
	var instance = test_scene.instantiate()
	get_tree().root.add_child(instance)
	self.queue_free()
	#get_tree().change_scene_to(test_scene)
	pass # Replace with function body.


func _on_host_lan_pressed():
	var server_instance = server_script.new()
	get_tree().root.add_child(server_instance)
	server_instance.start_server()  # Assuming there's a method named 'start_server' in your Server.gd
	pass # Replace with function body.


func _on_line_edit_property_list_changed():
	pass # Replace with function body.


func _on_join_lobby_pressed():
	# initialize as client
	pass # Replace with function body.


func _on_host_internet_pressed():
	# Start game StartGame.rpc()
	pass # Replace with function body.
