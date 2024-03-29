extends Control

# Map_Final is the map
# Biden is unique and not a generic character

@export var Address = "127.0.0.1"
@export var port = 8910
var peer

# Called when the node enters the scene tree for the first time.
func _ready():
	multiplayer.peer_connected.connect(peer_connected)
	multiplayer.peer_disconnected.connect(peer_disconnected)
	multiplayer.connected_to_server.connect(connected_to_server)
	multiplayer.connection_failed.connect(connection_failed)
	pass # Replace with function body.

func peer_connected(id):
	print("Player Connected " + str(id))

func peer_disconnected(id):
	print("Player Disconnected " + str(id))

func connected_to_server():
	print("Connected to Server!")
	SendPlayerInformation.rpc_id(1, $LineEdit.text, multiplayer.get_unique_id())

func connection_failed(id):
	print("Couldn't Connect")

@rpc("any_peer")
func SendPlayerInformation(name,id):
	if !GameManager.Players.has(id):
		GameManager.Players[id] = {
			"name": name,
			"id": id,
			"score": 0
		}
	if multiplayer.is_server():
		for i in GameManager.Players:
			SendPlayerInformation.rpc(GameManager.Players[i].name, i)

# Allow anyone to start the game
@rpc("any_peer", "call_local")
func StartGame():
	var scene = load ("res://Scenes/Map/map_final.tscn").instantiate()
	get_tree().root.add_child(scene)
	self.hide()


func _initialize_as_host():
	peer = ENetMultiplayerPeer.new()
	var error = peer.create_server(port, 6)
	if error != OK:
		print("cannont host:" + error)
		return

	peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
	multiplayer.set_multiplayer_peer(peer)

	print("Waiting For Players!")
	SendPlayerInformation("name test", multiplayer.get_unique_id())
	pass # Replace with function body.

func _on_start_game_button_down():
	StartGame.rpc()
	pass # Replace with function body.


func _initialize_as_client():
	var peer2 = ENetMultiplayerPeer.new()
	var error = peer2.create_client(Address, port)
	if error != OK:
		print("cannont create client:" + error)
		return
	peer2.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
	var multiplayer2 = get_tree().multiplayer
	multiplayer2.set_multiplayer_peer(peer2)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_view_assets_button_down():
	pass # Replace with function body.


func _on_load_map_button_down():
	pass # Replace with function body.

func _on_test_movement_button_down():
	pass # Replace with function body.

