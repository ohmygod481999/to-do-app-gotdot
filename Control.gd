extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(NodePath) var button

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_Button_pressed():
	$Popup.popup()

func _on_Button_2_pressed():
	$Panel/ItemList.add_item($Popup/Panel/TextEdit.text)
	$Popup.hide()
