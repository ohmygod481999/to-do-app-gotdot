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

func add_action(idx, action):
	for data_item in data:
		if data_item["id"] == idx:
			data_item["data"].append(action)

# Called when the node enters the scene tree for the first time.
func _ready():
	var collections = $Panel/LeftPanel/Body/ListCollection
	for data_item in data:
		collections.add_item(data_item["name"])
	$Panel/LeftPanel/Body/ListCollection.init_data(data)
	#reset_actions(1)

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
