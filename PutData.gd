extends HTTPRequest

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func put_done(username, secret, item):
	var query = JSON.print({
		"name": username,
		"secret": secret,
		"done": item
	})
	var url = "https://to-do-app-godot.herokuapp.com/to-do-lists/done"
	var headers = ["Content-Type: application/json"]
	request(url, headers, true, HTTPClient.METHOD_POST, query)
	print("done sent")

func put_tasks(__data, username, secret, id_complete):
	var data = [] + __data 
	var cnt = 0
	for _data in data:
		if _data["id"] == id_complete:
			data.remove(cnt)
		break
		cnt += 1
	var query = JSON.print({
		"name": username,
		"secret": secret,
		"data": data
	})
    # Add 'Content-Type' header:
	var url = "https://to-do-app-godot.herokuapp.com/to-do-lists/"
	var headers = ["Content-Type: application/json"]
	request(url, headers, true, HTTPClient.METHOD_PUT, query)
	print("data sent")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_PutData_request_completed(result, response_code, headers, body):
	var json = JSON.parse(body.get_string_from_utf8())
	#print(json.result)
