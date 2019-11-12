extends Control
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(NodePath) var button
export (PackedScene) var ListItem

const completed = "Completed"
const id_completed = 21012604
var username = "phuong"
var password = "concac"

var timer = 0

func _physics_process(delta):
	timer += 1
	if timer == 600:
		timer = 0
		$PutData.put_tasks(data, username, password, id_completed)

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
]

func get_done_list(name, secret):
	var query = JSON.print({
		"name": name,
		"secret": secret
	})
    # Add 'Content-Type' header:
	var url = "https://to-do-app-godot.herokuapp.com/to-do-lists/done-items"
	var headers = ["Content-Type: application/json"]
	$GetDoneList.request(url, headers, true, HTTPClient.METHOD_POST, query)

onready var icon = preload("res://CollectionIcon.tres")
onready var items_width = 50
onready var items_height = 50

func get_data(name, secret):
	var query = JSON.print({
		"name": name,
		"secret": secret
	})
    # Add 'Content-Type' header:
	var url = "https://to-do-app-godot.herokuapp.com/to-do-lists/"
	var headers = ["Content-Type: application/json"]
	$HTTPRequest.request(url, headers, true, HTTPClient.METHOD_POST, query)

func _on_HTTPRequest_request_completed( result, response_code, headers, body ):
	var json = JSON.parse(body.get_string_from_utf8())
	if json.result["data"]:
		username = json.result["data"]["name"]
		password = json.result["data"]["secret"]
		$Panel/LeftPanel/Head/user/username.init(username)
		var got_data = json.result["data"]["data"]
		#print(got_data)
		data = got_data
		reset_done()
		init_collections()
	else: 
		$"Wrong_account_popup()".popup()

func add_action(idx, action):
	data[idx]["data"].append(action)
	$Panel/LeftPanel/Body/ListCollection.init_data(data)

# Called when the node enters the scene tree for the first time.
func _ready():
	get_data("phuong", "phuongduongvat")
	get_done_list("phuong", "phuongduongvat")
	reset_done()
	init_collections()
	
func delete_task(list_index, index):
	done.append(data[list_index]["data"][index])
	$PutData.put_done(username, password, data[list_index]["data"][index])
	reset_done()
	data[list_index]["data"].remove(index)
	$PutData.put_tasks(data, username, password, id_completed)
	$Panel/LeftPanel/Body/ListCollection.reset_actions(list_index)
	
func init_collections():
	var collections = $Panel/LeftPanel/Body/ListCollection
	collections.clear()
	#print(data)
	for data_item in data:

		#collections.add_item(data_item["name"])
		#print(data_item["name"])

		var item = icon.duplicate()
		item.set_region(Rect2(0, 0, items_width, items_height))
		collections.add_item(data_item["name"], item)

	$Panel/LeftPanel/Body/ListCollection.init_data(data)

func delete_children(node):
	for n in node.get_children():
		node.remove_child(n)
		n.queue_free()

func _on_Button_pressed():
	$Popup.popup()

func _on_Button_2_pressed():
	var jobName = $Popup/Panel/TextEdit.text
	if jobName.length() > 0:
		$Panel/LeftPanel/Body/ListCollection.add_item(jobName)
		var sz = data.size()
		data.append({
			"id" : sz,
			"name" : jobName,
			"data" : []
			})
	init_collections()
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
		$Panel/LeftPanel/Body/ListCollection.reset_actions(listId)
	else:
		pass
		
		
func reset_done():
	var cnt = 0
	for _data in data:
		if _data["name"] == completed:
			data.remove(cnt)
			break
		cnt += 1
	data.append({
		"name": completed,
		"id": id_completed,
		"data": done
	})

func _on_Modify_button_pressed():
	var listId = $Panel/LeftPanel/Body/ListCollection.selected
	if (listId != -1):
		$List_modifier_popup.popup()
		
		
func _on_Login_Button_pressed(): 
	var user = $Login_popup/Login/usernameet.text
	var passw= $Login_popup/Login/passwordet.text
	get_data(user, passw)
	$Login_popup.hide()


func _on_Switch_Button_pressed():
	$Login_popup.show()


func _on_GetDoneList_request_completed(result, response_code, headers, body):
	print("got")
	var json = JSON.parse(body.get_string_from_utf8())
	if json.result["data"]:
		done = json.result["data"]
	reset_done()
	pass # Replace with function body.
