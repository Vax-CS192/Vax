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
signal a_slot_pressed(num)
signal a_slot_unpressed()
signal set_fav_enabled(status)

onready var enabled_fav_button = preload("res://Assets/Formula Book/Archive Page/Archive FormulaPopup/Set as Favorite Button enabled.png")
onready var disabled_fav_button = preload("res://Assets/Formula Book/Archive Page/Archive FormulaPopup/Set as Favorite Button.png")

onready var formula_parameters := {
	"ID":null,
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
var favorites_count=0

func _on_Popup_about_to_show(new_formula_parameters: Dictionary,fav_count:int):
	favorites_count=fav_count
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
	self.hide()

func _on_Popup_popup_hide():
	synch_formula_parameters()
	emit_signal("archive_deets_edited", formula_parameters)
	self.hide() # Replace with function body.

func _on_SetAsFavoriteButton_pressed():
	emit_signal("set_as_fav",formula_parameters["ID"])
	self.hide()


func _on_Slot1_pressed():
	#if $ArchivePopupControl/Slots/Slot1.is_pressed==true:
	emit_signal("a_slot_pressed",1)
	#else:
	#	emit_signal("a_slot_unpressed")

func _on_Slot2_pressed():
	#if $ArchivePopupControl/Slots/Slot2.is_pressed==true:
	emit_signal("a_slot_pressed",2)
	#else:
	#	emit_signal("a_slot_unpressed")

func _on_Slot3_pressed():
	#if $ArchivePopupControl/Slots/Slot3.is_pressed==true:
	emit_signal("a_slot_pressed",3)
	#else:
	#	emit_signal("a_slot_unpressed")

func _on_Slot4_pressed():
	#if $ArchivePopupControl/Slots/Slot4.is_pressed==true:
	emit_signal("a_slot_pressed",4)
	#else:
	#	emit_signal("a_slot_unpressed")

func _on_Slot5_pressed():
	#if $ArchivePopupControl/Slots/Slot5.is_pressed==true:
	emit_signal("a_slot_pressed",5)
	#else:
	#	emit_signal("a_slot_unpressed")

func _on_Slot6_pressed():
	#if $ArchivePopupControl/Slots/Slot6.is_pressed==true:
	emit_signal("a_slot_pressed",6)
	#else:
	#	emit_signal("a_slot_unpressed")

func _on_Slot7_pressed():
	#if $ArchivePopupControl/Slots/Slot7.is_pressed==true:
	emit_signal("a_slot_pressed",7)
	#else:
	#	emit_signal("a_slot_unpressed")

func _on_Slot8_pressed():
	#if $ArchivePopupControl/Slots/Slot8.is_pressed==true:
	emit_signal("a_slot_pressed",8)
	#else:
	#	emit_signal("a_slot_unpressed")

func _on_Slot9_pressed():
	#if $ArchivePopupControl/Slots/Slot9.is_pressed==true:
	emit_signal("a_slot_pressed",9)
	#else:
	#	emit_signal("a_slot_unpressed")

func _on_Slot10_pressed():
	#if $ArchivePopupControl/Slots/Slot10.is_pressed==true:
	emit_signal("a_slot_pressed",10)
	#else:
	#	emit_signal("a_slot_unpressed")

func _a_slot_pressed(num):
	for i in range(10):
		var slot_path="ArchivePopupControl/Slots/Slot"+str(i+1)
		if i < favorites_count:
			continue
		elif (i+1)==num:
			if get_node(slot_path).is_pressed==true: #Previously pressed toggle to false
				get_node(slot_path).is_pressed=false
				get_node(slot_path).is_disabled=true
				emit_signal("a_slot_unpressed")
			else:
				get_node(slot_path).is_disabled=false
				get_node(slot_path).is_pressed=true
				$ArchivePopupControl/SetAsFavoriteButton.texture_normal=enabled_fav_button
				emit_signal("set_fav_enabled",true)
		else:
			get_node(slot_path).is_disabled=true


func _a_slot_unpressed():
	$ArchivePopupControl/SetAsFavoriteButton.texture_normal=disabled_fav_button
	emit_signal("set_fav_enabled",false)
			
