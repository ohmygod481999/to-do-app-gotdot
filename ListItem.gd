# Declare member variables here. Examples:
# var a = 2
# var b = "text"
extends Panel
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func init(value):
	get_node("Label").text = value

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
