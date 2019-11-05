extends ItemList

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
var ListPanel
var selected = -1
func _ready():
	ListPanel = get_node("/root/Control/Panel/RightPanel/List")
	pass # Replace with function body.
	
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
var pre_load = {}

func init_data(_data):
	data = _data

func delete_children(node):
	for n in node.get_children():
		node.remove_child(n)
		n.queue_free()

func _on_ListCollection_item_selected(index):
	selected = index
	var text = get_item_text(index)
	var idx = 0
	for item in data:
		if item["name"] == text:
			break
		idx += 1
	if idx < data.size():
		var lists
		#if pre_load.get(str(idx)) == null:
			#lists = preload("res://List.tscn").instance()
			#lists.init(data[idx]["data"])
			#pre_load[str(idx)] = lists
		#else:
			#lists = pre_load[str(idx)]
		lists = preload("res://List.tscn").instance()
		lists.init(data[idx]["data"])
		delete_children(ListPanel)
		ListPanel.add_child(lists)
		
	pass # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
