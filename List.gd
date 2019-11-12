extends ScrollContainer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var index = -1
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var item_height = 50

func delete_child(idx: int):
	var children = get_children()
	for child in children:
		var child_idx = child.index
		if child_idx == idx:
			print("found")
			remove_child(child)
			break
			
func init_idx(idx):
	index = idx

func init(data):
	var counter = 0
	for item in data:
		var item_node = preload("res://ListItem.tscn").instance()
		item_node.init(item)
		item_node.init_idx(counter, index)
		
		#item_node.anchor.x = 0
		#item_node.anchor.y = 0
		item_node.rect_position.x = 0
		item_node.rect_position.y = item_height * counter
		var VBox = get_child(2)
		#print(control)
		VBox.add_child(item_node)
		counter += 1
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
