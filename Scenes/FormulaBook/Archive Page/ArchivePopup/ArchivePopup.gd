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

onready var enabled_fav_button = preload("res://Assets/Formula Book/Archive Page/Archive Formula Page/Set as Favorite Button enabled.png")
onready var disabled_fav_button = preload("res://Assets/Formula Book/Archive Page/Archive Formula Page/Set as Favorite Button.png")


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$ArchivePopupControl/Slots/Slot1.is_occupied=true
	$ArchivePopupControl/Slots/Slot2.is_occupied=true
	$ArchivePopupControl/Slots/Slot3.is_occupied=true
	$ArchivePopupControl/Slots/Slot4.is_occupied=true
	$ArchivePopupControl/Slots/Slot5.is_occupied=true
	$ArchivePopupControl/Slots/Slot6.is_occupied=true
	$ArchivePopupControl/Slots/Slot7.is_occupied=true
	$ArchivePopupControl/Slots/Slot8.is_occupied=true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	#Fix this hardcoded code
	if $ArchivePopupControl/Slots/Slot9.is_pressed==true || $ArchivePopupControl/Slots/Slot10.is_pressed==true:
		$ArchivePopupControl/SetAsFavoriteButton.texture_normal=enabled_fav_button
		if $ArchivePopupControl/Slots/Slot9.is_pressed==true:
			$ArchivePopupControl/Slots/Slot10.is_disabled=true              
		elif $ArchivePopupControl/Slots/Slot10.is_pressed==true:
			$ArchivePopupControl/Slots/Slot9.is_disabled=true 
	else:
		$ArchivePopupControl/Slots/Slot9.is_disabled=false
		$ArchivePopupControl/Slots/Slot10.is_disabled=false
		$ArchivePopupControl/SetAsFavoriteButton.texture_normal=disabled_fav_button
