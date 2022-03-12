extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Confirm_pressed():
	var vaccine_name = $VaccineName.get_text()
	var vaccine_description = $VaccineDesc.get_text()
	var popup_handle = get_parent()
	var mainui_handle = popup_handle.get_parent()
	mainui_handle.confirm(vaccine_name, vaccine_description)
	$VaccineName.set_text("")
	$VaccineDesc.set_text("")
	popup_handle.hide()
