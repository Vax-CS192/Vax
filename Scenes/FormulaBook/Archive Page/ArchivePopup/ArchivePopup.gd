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
signal set_as_fav(id)
signal set_fav_enabled(status)

onready var enabled_fav_button = preload("res://Assets/Formula Book/Archive Page/Archive FormulaPopup/Set as Favorite Button enabled.png")
onready var disabled_fav_button = preload("res://Assets/Formula Book/Archive Page/Archive FormulaPopup/Set as Favorite Button.png")

onready var formula_parameters := {
	"ID":null,
	"Description":"",
	"MassProducePrice":0,
	"Components": []
}

var favorites_count=0
var slot_available = false
#reset to default
func reset():
	for i in range(10):
		var slot_path="ArchivePopupControl/Slots/Slot"+str(i+1)
		if get_node(slot_path).is_occupied==false:
			get_node(slot_path).is_pressed = false
			get_node(slot_path).is_disabled = true
	$ArchivePopupControl/SetAsFavoriteButton.texture_normal=disabled_fav_button

#populate slots. Reflect Favorites page
func _on_Popup_about_to_show(new_formula_parameters: Dictionary,fav_count:int):
	favorites_count=fav_count
	if favorites_count<10:
		$ArchivePopupControl/SetAsFavoriteButton.texture_normal=enabled_fav_button
		slot_available = true
	else:
		$ArchivePopupControl/SetAsFavoriteButton.texture_normal=disabled_fav_button
		slot_available = false
		
	formula_parameters = new_formula_parameters
	$ArchivePopupControl/FormulaName.text=formula_parameters["ID"]
	$ArchivePopupControl/FormulaNote.text= formula_parameters["Description"]
	for i in range(10):
		var slot_path="ArchivePopupControl/Slots/Slot"+str(i+1)
		if i < fav_count:
			get_node(slot_path).is_occupied=true
		else:
			get_node(slot_path).is_occupied=false
	self.popup_centered()

func synch_formula_parameters():
	formula_parameters["ID"]=$ArchivePopupControl/FormulaName.text
	formula_parameters["Description"]=$ArchivePopupControl/FormulaNote.text
	
#Emits signal
func _on_DeleteButton_pressed():
	emit_signal("delete_an_archive",formula_parameters["ID"])
	reset()
	self.hide()

func _on_Popup_popup_hide():
	synch_formula_parameters()
	emit_signal("archive_deets_edited", formula_parameters)
	reset()
	self.hide() # Replace with function body.

func _on_SetAsFavoriteButton_pressed():
	if slot_available:
		print(formula_parameters["ID"])
		emit_signal("set_as_fav",formula_parameters["ID"])
		reset()
	self.hide()
