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


extends Node

var max_page=2
var curr_page:int = 1
const last_page = 2
var occupied_page = true
#add maxselectedslots

# Called every frame. 'delta' is the elapsed time since the previous frame.
# The formula name and state are set here.
func _process(delta):
	if occupied_page:
		_load_page()
	#Set Formula State and Name
	else:
		_new_page()

		
func _load_page():
	#set state
	$ArchiveIcons/ArchiveIcon1.is_occupied=true
	$ArchiveIcons/ArchiveIcon2.is_occupied=true

	#set names
	$ArchiveIcons/ArchiveIcon1/Name.text = "Really"
	$ArchiveIcons/ArchiveIcon2/Name.text = "Try"
	
	
func _new_page():
	$ArchiveIcons/ArchiveIcon1.is_occupied=false
	$ArchiveIcons/ArchiveIcon2.is_occupied=false
	
	#reset names
	$ArchiveIcons/ArchiveIcon1/Name.text = ""
	$ArchiveIcons/ArchiveIcon2/Name.text = ""


#Go to Cauldron Subsystem when the button is pressed	
func _on_BackButton_pressed():
	get_tree().change_scene("res://Scenes/FormulaBook/FormulaBook.tscn")

#Task: Create a function that will load all details of a page when nav buttons are pressed

func _on_ArchiveIcon_pressed():
	$ArchivePopup.popup_centered()


func _on_LeftButton_pressed():
	if curr_page==1:#before update
		occupied_page=false 
		curr_page =last_page
	elif curr_page==2:
		occupied_page=true
		curr_page -=1
	else:
		occupied_page=false
		curr_page -=1
	$ArchivePageControl/PageField/TextField.text = str(curr_page)

func _on_RightButton_pressed():
	if curr_page==last_page: #before update
		occupied_page=true #go back to first page
		curr_page =1
	else:
		occupied_page=false
		curr_page +=1
	$ArchivePageControl/PageField/TextField.text = str(curr_page)


func _on_TextField_text_entered(new_text):
	var text_page = int($ArchivePageControl/PageField/TextField.text)
	if text_page>max_page:
		$ArchivePageControl/PageField/TextField.text=str(curr_page)
	else:
		curr_page=text_page
		#update page
		if curr_page==1:#before update
			occupied_page=true
		elif curr_page==2:
			occupied_page=false
	
