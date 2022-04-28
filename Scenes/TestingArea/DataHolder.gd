extends Popup


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func show_info(patient_data):
	$Report.set_info(patient_data)
	popup(Rect2(650,380,1591,727))
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
