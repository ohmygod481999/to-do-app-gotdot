# Declare member variables here. Examples:
# var a = 2
# var b = "text"
extends Panel
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
var index = -1
var list_index = -1
	
func init(value):
	get_node("Label").text = value
	
func init_idx(idx, list_idx):
	index = idx
	list_index = list_idx

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_CheckBox_toggled(button_pressed):
	var ListPanel = get_node("/root/Control")
	ListPanel.delete_task(list_index, index)
	print(list_index)
	pass # Replace with function body.