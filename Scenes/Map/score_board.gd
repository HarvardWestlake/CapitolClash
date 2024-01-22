extends CanvasLayer

var score_Dem = 0
var score_Rep = 0
var score_label_Dem
var score_label_Rep

func _ready():
	score_label_Dem = $RepublicanScore
	score_label_Rep = $DemocratScore

func update_score_Dem(points: int):
	score_Dem = points
	score_label_Dem.text = "Democrats: " + str(score_Dem)
	check_for_winner()
		

func update_score_Rep(points: int):
	score_Rep = points
	score_label_Rep.text = "Republicans: " + str(score_Rep)
	check_for_winner()
	
func check_for_winner():
	if score_Dem >= 270 or score_Rep >= 270:
		var victory_scene_resource = load("res://Scenes/Map/victory_temp.tscn")
		if victory_scene_resource:
			var victory_scene = victory_scene_resource.instantiate()
			# Add the victory scene to the scene tree
			get_tree().get_root().add_child(victory_scene)
			# Optional: Remove the current scene from the scene tree if needed
			get_tree().get_current_scene().queue_free()
			# Change to the new scene
			get_tree().set_current_scene(victory_scene)
		else:
			print("Failed to load scene")
	else:
		$victory_temp.hide()
		
