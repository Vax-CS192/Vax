extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Title.margin_top = -500
	$Buttons.margin_top = (get_viewport_rect().size.y / 5)
	$Buttons.margin_left = $Buttons.rect_size.x/6.5


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_NewGame_pressed():
	pass # Go to Cutscene


func _on_Continue_pressed():
	pass # Go to Lab


func _on_Exit_pressed():
	get_tree().quit()
