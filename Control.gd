extends Control
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(NodePath) var button
export (PackedScene) var ListItem

var data = [
	{
		"id": 0,
		"name": "List1",
		"data": [
			"data1",
			"data2",
			"data3"
		]
	},
	{
		"id": 1,
		"name": "List2",
		"data": [
			"data4",
			"data5",
			"data6"
		]
	}
]

var done = [
	"done1",
	"done2"
]

func get_data(username, password):
	$Panel/LeftPanel/Head/user/username.init(username)
	var query = JSON.print({
		"name": username,
		"secret": password
	})
    # Add 'Content-Type' header:
	var url = "https://to-do-app-godot.herokuapp.com/to-do-lists/"
	var headers = ["Content-Type: application/json"]
	$HTTPRequest.request(url, headers, true, HTTPClient.METHOD_POST, query)
	print("sent")

func _on_HTTPRequest_request_completed( result, response_code, headers, body ):
	var json = JSON.parse(body.get_string_from_utf8())
	if json.result["data"]:
		var got_data = json.result["data"]["data"]
		#print(got_data)
		data = got_data
		init_collections()

func add_action(idx, action):
	for data_item in data:
		if data_item["id"] == idx:
			data_item["data"].append(action)

# Called when the node enters the scene tree for the first time.
func _ready():
	get_data("facker", "iovedanong")
	init_collections()
	#reset_actions(1)
	
func init_collections():
	var collections = $Panel/LeftPanel/Body/ListCollection
	collections.clear()
	for data_item in data:
		collections.add_item(data_item["name"])
	$Panel/LeftPanel/Body/ListCollection.init_data(data)

func delete_children(node):
	for n in node.get_children():
		node.remove_child(n)
		n.queue_free()

func _on_Button_pressed():
	$Popup.popup()

func _on_Button_2_pressed():
	$Panel/LeftPanel/Body/ListCollection.add_item($Popup/Panel/TextEdit.text)
	$Popup.hide()



func _on_Cancel_pressed():
	$List_modifier_popup.hide()


func _on_OK_pressed():
	var id = $List_modifier_popup/List_modifier/OptionButton.selected
	if (id == 0):
		var listId = $Panel/LeftPanel/Body/ListCollection.selected
		var action = $List_modifier_popup/List_modifier/Panel/Action.text
		add_action(listId, action)
		$List_modifier_popup.hide()
		#reset_actions(listId)
	else:
		pass
		
		


func _on_Modify_button_pressed():
	var listId = $Panel/LeftPanel/Body/ListCollection.selected
	if (listId != -1):
		$List_modifier_popup.popup()
