extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_info(patient_data):
	$Fever.text = patient_data["0"]
	$Body.text = patient_data["1"]
	$Breathless.text = patient_data["2"]
	$Tiredness.text = patient_data["3"]
	$Coughing.text = patient_data["4"]
#func _process(delta):
#	pass
