extends LineEdit

onready var enter_button = $UI/TextureButton

var my_style = StyleBoxFlat.new()

func _ready():
	my_style.set_bg_color(Color(1,1,1,1))
	my_style.corner_radius_bottom_left = 75
	my_style.corner_radius_bottom_right = 75
	my_style.corner_radius_top_left = 75
	my_style.corner_radius_top_right = 75
	set("custom_styles/normal", my_style)

func _process(delta):
	if self.text == "":
		pass


func _on_TextureButton_pressed():
	get_tree().change_scene("res://Scenes/Lab/Lab.tscn")
