extends Control 

func _ready():
	$LabBG.position.x = get_viewport_rect().size.x / 2
	$LabBG.position.y = get_viewport_rect().size.y / 4


func _on_Formula1_pressed():
	get_tree().change_scene("res://Scenes/FormulaBook/FormulaBook.tscn")


func _on_Formula2_pressed():
	get_tree().change_scene("res://Scenes/Shop/Shop.tscn")


func _on_BackToMainMenu_pressed():
	get_tree().change_scene("res://Scenes/MainMenu/MainMenu.tscn")


func _on_Formula3_pressed():
	print('Wala pang scene')


func _on_Formula4_pressed():
	print('Wala pang scene')
