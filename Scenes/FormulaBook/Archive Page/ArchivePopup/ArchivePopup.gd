# Author: Aira Mae E. Aloveros
# License: 0BSD
# Permission to use, copy, modify, and/or distribute this software for any purpose with or without 
# fee is hereby granted.

# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS 
# SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE 
# AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES 
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, 
# NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE 
# OF THIS SOFTWARE.


extends Popup
signal delete_an_archive(id)
signal archive_deets_edited(formula_parameters)

onready var enabled_fav_button = preload("res://Assets/Formula Book/Archive Page/Archive FormulaPopup/Set as Favorite Button enabled.png")
onready var disabled_fav_button = preload("res://Assets/Formula Book/Archive Page/Archive FormulaPopup/Set as Favorite Button.png")

onready var formula_parameters := {
	"ID":null,
	"Name": "",
	"Description":"",
	"MassProducePrice":0,
	"Components": []
}

# Declare member variables here. Examples:
# var a = 2
# var b = "text"



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	
	#Fix this hardcoded code
#	if $ArchivePopupControl/Slots/Slot9.is_pressed==true || $ArchivePopupControl/Slots/Slot10.is_pressed==true:
#		$ArchivePopupControl/SetAsFavoriteButton.texture_normal=enabled_fav_button
#		if $ArchivePopupControl/Slots/Slot9.is_pressed==true:
#			$ArchivePopupControl/Slots/Slot10.is_disabled=true              
#		elif $ArchivePopupControl/Slots/Slot10.is_pressed==true:
#			$ArchivePopupControl/Slots/Slot9.is_disabled=true 
#	else:
#		$ArchivePopupControl/Slots/Slot9.is_disabled=false
#		$ArchivePopupControl/Slots/Slot10.is_disabled=false
#		$ArchivePopupControl/SetAsFavoriteButton.texture_normal=disabled_fav_button


func _on_Popup_about_to_show(new_formula_parameters: Dictionary,fav_count:int):
	formula_parameters = new_formula_parameters
	$ArchivePopupControl/FormulaName.text=formula_parameters["Name"]
	$ArchivePopupControl/FormulaNote.text= formula_parameters["Description"]
	for i in range(10):
		var slot_path="ArchivePopupControl/Slots/Slot"+str(i+1)
		if i < fav_count:
			get_node(slot_path).is_occupied=true
		else:
			get_node(slot_path).is_occupied=false
	self.popup_centered()

func synch_formula_parameters():
	formula_parameters["Name"]=$ArchivePopupControl/FormulaName.text
	formula_parameters["Description"]=$ArchivePopupControl/FormulaNote.text
	
#Emits signal
func _on_DeleteButton_pressed():
	emit_signal("delete_an_archive",formula_parameters["ID"])
	self.hide()


func _on_Popup_popup_hide():
	synch_formula_parameters()
	emit_signal("archive_deets_edited", formula_parameters)
	self.hide() # Replace with function body.
