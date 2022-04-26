extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_message(some_message):
	$Message.text = some_message
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
