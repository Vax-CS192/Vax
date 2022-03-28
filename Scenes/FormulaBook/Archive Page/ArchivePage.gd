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

onready var formula_file_path = "user://formuladirectory.save"
onready var favorites_file_path = "user://favoritesdirectory.save"

onready var fav_count=0
var max_page=2
var curr_page:int = 1
const last_page = 2
var occupied_page = true


onready var all_formula=[]
onready var curr_page_formula=[]

# Called when the node enters the scene tree for the first time.
# Loads Popup names
func _ready():
	$ArchivePageUI/Money/Account.text="PHP "+ Profile.format_money(Profile.money)
	#add_to_formulabook("formula_name","formula_description",["1","2","3","4","5"])
	#Create Formula save fiiles is not yet existing, otherwise load the data
	#Load presaved formula
	initialize_archive_page() 
	set_archive_page()
	fav_count = favorites_counts()

#read all formula
func initialize_archive_page():
	var file = File.new()
	file.open(formula_file_path, File.READ)
	var index = 1
	var a_page = []
	while not file.eof_reached(): # iterate thrrough all lines until the end of file is reached
		var dict = parse_json(file.get_line())
		if dict==null:
			continue

		a_page.append(dict)
		if len(a_page)==20:
			curr_page_formula.append(a_page)
			a_page=[]
		index += 1
	if (index-1)%20!=0: #if last page has excess
		curr_page_formula.append(a_page)
	file.close()

func favorites_counts():
	var file = File.new()
	file.open(favorites_file_path, File.READ)
	while not file.eof_reached():
		var dict = parse_json(file.get_line())
		if dict==null:
			continue
		fav_count+=1
	file.close()

#Sets up the favorites page's formula
func set_archive_page():
	#print(curr_page_formula)
	var page_formula = curr_page_formula[curr_page-1] #list of directories in a page
	print(page_formula)
	var index = 1
	var slot_path = ""
	while index<=len(page_formula):
		var dict=page_formula[index-1]
		print(dict)
		slot_path = "ArchiveIcons/ArchiveIcon"+str(index)
		if dict!=null:
			get_node(slot_path+"/Name").text=dict["Name"]
			get_node(slot_path).is_occupied=true
			index += 1
			
	if index<=20: #set occupied to false
		while index<=20:
			print(index)
			slot_path = "ArchiveIcons/ArchiveIcon"+str(index)
			get_node(slot_path).is_occupied=false
			index+=1
	
# Load the page with occupied folders		
# Task: Create a function that will load all details of a page when nav buttons are pressed
func _load_page():
	#set state
	$ArchiveIcons/ArchiveIcon1.is_occupied=true
	$ArchiveIcons/ArchiveIcon2.is_occupied=true

	#set names
	$ArchiveIcons/ArchiveIcon1/Name.text = "Really"
	$ArchiveIcons/ArchiveIcon2/Name.text = "Try"
	
#load a page with empty foalders (only for the demo)
func _new_page():
	$ArchiveIcons/ArchiveIcon1.is_occupied=false
	$ArchiveIcons/ArchiveIcon2.is_occupied=false
	
	#reset names
	$ArchiveIcons/ArchiveIcon1/Name.text = ""
	$ArchiveIcons/ArchiveIcon2/Name.text = ""


# Go to Cauldron Subsystem when the button is pressed	
func _on_BackButton_pressed():
	get_tree().change_scene("res://Scenes/FormulaBook/FormulaBook.tscn")

# Moves to the next page
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


# Moves to the previous page
func _on_RightButton_pressed():
	if curr_page==last_page: #before update
		occupied_page=true #go back to first page
		curr_page =1
	else:
		occupied_page=false
		curr_page +=1
	$ArchivePageControl/PageField/TextField.text = str(curr_page)

# Moves to the page number according to the user's input
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
