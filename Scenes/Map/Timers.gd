extends Control


# Called when the node enters the scene tree for the first time.
func initialize():
	for i in range(17):
		get_child(i).set_region(i)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
