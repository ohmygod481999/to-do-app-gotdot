extends Panel

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	_init_option()

func _init_option():
	$OptionButton.add_item("Add action")
	$OptionButton.add_item("Delete list action")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_OptionButton_item_selected(ID):
	if (ID == 0): 
		$Panel.show()
	else:
		$Panel.hide()
		





func _on_Cancel_pressed():
	if (self.owner != null) :
		self.owner._on_Cancel_pressed()


func _on_OK_pressed():
	if (self.owner != null) :
		self.owner._on_OK_pressed()
