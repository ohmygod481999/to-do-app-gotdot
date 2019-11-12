extends Label

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var time = OS.get_datetime()
var dayofweek = time["weekday"]

var map_date = {
	0: "Sunday",
	1: "Monday",
	2: "Tuesday",
	3: "Wednesday",
	4: "Thursday",
	5: "Friday",
	6: "Sartuday"
}

func get_date_format():
	return map_date[dayofweek] + ", " + str(time["day"]) + "/" + str(time["month"]) + "/" + str(time["year"])
# Called when the node enters the scene tree for the first time.
func _ready():
	text = get_date_format()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
