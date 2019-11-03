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

var listDone = [
	"done1",
	"done2"
]

# Called when the node enters the scene tree for the first time.
func _ready():
	var collections = $Panel/LeftPanel/Body/ListCollection
	for data_item in data:
		collections.add_item(data_item["name"])
	reset_actions(1)

func delete_children(node):
	for n in node.get_children():
		node.remove_child(n)
		n.queue_free()

func reset_actions(id):
	var action_panel = $Panel/RightPanel/List/ListAction
	delete_children(action_panel)
	for data_item in data:
		if data_item["id"] == id:
			for item in data_item["data"]:
				var myItem = preload("res://ListItem.tscn").instance()
				myItem.init(item)
				action_panel.add_item(myItem)
			break

func _on_Button_pressed():
	$Popup.popup()

func _on_Button_2_pressed():
	$Panel/LeftPanel/Body/ListCollection.add_item($Popup/Panel/TextEdit.text)
	$Popup.hide()
