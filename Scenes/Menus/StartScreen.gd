extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass




func _on_quit_button_down():
	get_tree().quit()


func _on_start_button_down():
	var scene = load("res://Scenes/Menus/MainMenu.tscn").instantiate()
	get_tree().root.add_child(scene)
	self.hide()