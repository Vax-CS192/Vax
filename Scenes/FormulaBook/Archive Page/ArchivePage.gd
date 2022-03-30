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


extends Node2D

signal archives_changed() #indicates that the there has been some changes in the formula archive file
signal archives_closed()
signal an_archive_to_fave(formulae_temp)
signal favorites_changed()

onready var formula_file_path = "user://formuladirectory.save"
onready var favorites_file_path = "user://favoritesdirectory.save"

onready var fav_count=0
var curr_page:int = 1
var occupied_page = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
# The formula name and state are set here.
func _process(delta):
	pass
		
onready var all_formula=[]
onready var curr_page_formula=[]

# Called when the node enters the scene tree for the first time.
# Loads Popup names
func _ready():
	_archives_changed()
	count_favorites()

	
# Called when the archive file is changed
func _archives_changed():
	print("[ARCHIVE PAGE IS SETTING UP]")
	#reset
	all_formula=[]
	curr_page_formula=[]
	
	
	#add_to_formulabook("formula_name","formula_description",["1","2","3","4","5"])
	#Create Formula save fiiles is not yet existing, otherwise load the data
	#Load presaved formula
	initialize_archive_page() 
	set_archive_page()
	print("[Formula]: ",all_formula)



#read all formula
func initialize_archive_page():
	var file = File.new()
	if file.file_exists(formula_file_path):
		file.open(formula_file_path, File.READ)
		var index = 1
		var a_page = []
		while not file.eof_reached(): # iterate thrrough all lines until the end of file is reached
			var dict = parse_json(file.get_line())
			if dict==null:
				continue
			print("GOT: ",dict)
			all_formula.append(dict)
			a_page.append(dict)
			if len(a_page)==20:
				curr_page_formula.append(a_page)
				a_page=[]
			index += 1
		if (index-1)%20!=0: #if last page has excess
			curr_page_formula.append(a_page)
		file.close()
	else: 
		pass

func count_favorites():
	fav_count=0
	var file = File.new()
	if file.file_exists(favorites_file_path):
		file.open(favorites_file_path, File.READ)
		while not file.eof_reached():
			var dict = parse_json(file.get_line())
			if dict==null:
				continue
			fav_count+=1
		file.close()
	else: 
		pass

#Sets up the favorites page's formula
func set_archive_page():
	var index = 1
	var slot_path = ""
	if len(curr_page_formula)>0:	
		var page_formula = curr_page_formula[curr_page-1] #list of directories in a page

		while index<=len(page_formula):
			var dict=page_formula[index-1]
			slot_path = "ArchiveIcons/ArchiveIcon"+str(index)
			if dict!=null:
				get_node(slot_path+"/Name").text=dict["Name"]
				get_node(slot_path).is_occupied=true
				index += 1
				
		if index<=20: #set occupied to false
			while index<=20:
				slot_path = "ArchiveIcons/ArchiveIcon"+str(index)
				get_node(slot_path+"/Name").text=""
				get_node(slot_path).is_occupied=false
				index+=1
	else:
		#clear the page
		while index<=20:
			slot_path = "ArchiveIcons/ArchiveIcon"+str(index)
			get_node(slot_path+"/Name").text=""
			get_node(slot_path).is_occupied=false
			index+=1


# Go to Cauldron Subsystem when the button is pressed	
func _on_BackButton_pressed():
	self.hide()
	PersistentScenes.formulaBook.show()

# Moves to the next page
func _on_LeftButton_pressed():
	if curr_page==1:#before update
		occupied_page=false 
		curr_page =len(curr_page_formula)
	elif curr_page==2:
		occupied_page=true
		curr_page -=1
	else:
		occupied_page=false
		curr_page -=1
	$ArchivePageControl/PageField/TextField.text = str(curr_page)
	emit_signal("archives_changed")

# Moves to the previous page
func _on_RightButton_pressed():
	if curr_page==len(curr_page_formula): #before update
		occupied_page=true #go back to first page
		curr_page =1
	else:
		occupied_page=false
		curr_page +=1
	$ArchivePageControl/PageField/TextField.text = str(curr_page)
	emit_signal("archives_changed")

# Moves to the page number according to the user's input
func _on_TextField_text_entered(new_text):
	var text_page = int($ArchivePageControl/PageField/TextField.text)
	print("LEN",len(curr_page_formula))
	if text_page>len(curr_page_formula):
		$ArchivePageControl/PageField/TextField.text=str(curr_page)
	else:
		curr_page=text_page
		#update page
		if curr_page==1:#before update
			occupied_page=true
		elif curr_page==2:
			occupied_page=false
	emit_signal("archives_changed")


#Go to corresponding Cauldron Subsystem when the button is pressed. Task: Merge into one method if kaya
func _on_Archive_pressed(fp_slot):
	if len(all_formula)>0:
		var formula_parameters= curr_page_formula[curr_page-1] [fp_slot-1] #fp_slot names are 1-index
		count_favorites()
		print("BEFORE POPUP, FAV IS ", fav_count)
		$Popup._on_Popup_about_to_show(formula_parameters,fav_count)
		#$Popup.popup_centered()


#Hard coded since we need to know the button name
func _on_ArchiveIcon1_pressed():
	if $ArchiveIcons/ArchiveIcon1.is_occupied==true:
		_on_Archive_pressed(1)
	else:
		pass

func _on_ArchiveIcon2_pressed():
	if $ArchiveIcons/ArchiveIcon2.is_occupied==true:
		_on_Archive_pressed(2)
	else:
		pass

func _on_ArchiveIcon3_pressed():
	if $ArchiveIcons/ArchiveIcon3.is_occupied==true:
		_on_Archive_pressed(3)
	else:
		pass

func _on_ArchiveIcon4_pressed():
	if $ArchiveIcons/ArchiveIcon4.is_occupied==true:
		_on_Archive_pressed(4)
	else:
		pass

func _on_ArchiveIcon5_pressed():
	if $ArchiveIcons/ArchiveIcon5.is_occupied==true:
		_on_Archive_pressed(5)
	else:
		pass

func _on_ArchiveIcon6_pressed():
	if $ArchiveIcons/ArchiveIcon6.is_occupied==true:
		_on_Archive_pressed(6)
	else:
		pass

func _on_ArchiveIcon7_pressed():
	if $ArchiveIcons/ArchiveIcon7.is_occupied==true:
		_on_Archive_pressed(7)
	else:
		pass
		
func _on_ArchiveIcon8_pressed():
	if $ArchiveIcons/ArchiveIcon8.is_occupied==true:
		_on_Archive_pressed(8)
	else:
		pass

func _on_ArchiveIcon9_pressed():
	if $ArchiveIcons/ArchiveIcon9.is_occupied==true:
		_on_Archive_pressed(9)
	else:
		pass

func _on_ArchiveIcon10_pressed():
	if $ArchiveIcons/ArchiveIcon10.is_occupied==true:
		_on_Archive_pressed(10)
	else:
		pass
		
		
func _on_ArchiveIcon11_pressed():
	if $ArchiveIcons/ArchiveIcon11.is_occupied==true:
		_on_Archive_pressed(11)
	else:
		pass

func _on_ArchiveIcon12_pressed():
	if $ArchiveIcons/ArchiveIcon12.is_occupied==true:
		_on_Archive_pressed(12)
	else:
		pass

func _on_ArchiveIcon13_pressed():
	if $ArchiveIcons/ArchiveIcon13.is_occupied==true:
		_on_Archive_pressed(13)
	else:
		pass

func _on_ArchiveIcon14_pressed():
	if $ArchiveIcons/ArchiveIcon14.is_occupied==true:
		_on_Archive_pressed(14)
	else:
		pass

func _on_ArchiveIcon15_pressed():
	if $ArchiveIcons/ArchiveIcon15.is_occupied==true:
		_on_Archive_pressed(15)
	else:
		pass

func _on_ArchiveIcon16_pressed():
	if $ArchiveIcons/ArchiveIcon16.is_occupied==true:
		_on_Archive_pressed(16)
	else:
		pass

func _on_ArchiveIcon17_pressed():
	if $ArchiveIcons/ArchiveIcon17.is_occupied==true:
		_on_Archive_pressed(17)
	else:
		pass
		
func _on_ArchiveIcon18_pressed():
	if $ArchiveIcons/ArchiveIcon18.is_occupied==true:
		_on_Archive_pressed(18)
	else:
		pass

func _on_ArchiveIcon19_pressed():
	if $ArchiveIcons/ArchiveIcon19.is_occupied==true:
		_on_Archive_pressed(19)
	else:
		pass

func _on_ArchiveIcon20_pressed():
	if $ArchiveIcons/ArchiveIcon20.is_occupied==true:
		_on_Archive_pressed(20)
	else:
		pass
		
#Deltes the sent id
func _on_Popup_delete_an_archive(id):
	var index=0
	for formulae in all_formula:
		print(formulae)
		if formulae["ID"]==id:
			all_formula.remove(index)
			break
		index+=1
	$Popup.hide()
	save_archives_data()


func save_archives_data():
	var remove_data = File.new()
	if remove_data.file_exists(formula_file_path):
		remove_data.remove_meta(formula_file_path)
	print(all_formula)
	var save_data = File.new()
	save_data.open(formula_file_path, File.WRITE)
	for formulae in all_formula:
		if formulae!=null:
			print("writing...", formulae)
			#save_data.seek_end()
			save_data.store_line(to_json(formulae))
	save_data.close()
	emit_signal("archives_changed")


func _on_Popup_archive_deets_edited(formula_parameters):
	var index=0
	for formulae in all_formula:
		if formulae["ID"]==formula_parameters["ID"]:
			print("EDITED TO",formula_parameters)
			all_formula[index]=formula_parameters
			break
		index+=1
	save_archives_data()
	emit_signal("archives_changed")
	
#Transfer data from archives to favorites file
func _on_Popup_set_as_fav(id):
	#temporarily store formulae
	var index =0 
	var formulae_temp={}
	for formulae in all_formula:
		if formulae["ID"]==id:
			formulae_temp=formulae
			#delete in archives
			all_formula.remove(index)
			break
		index+=1
	#save changes to file

	print("[SENDING]...",formulae_temp)
	save_archives_data()
	_ready()
	
	#Append the formula at the end of the file
	var save_data = File.new()
	save_data.open(favorites_file_path, File.READ_WRITE)
	save_data.seek_end()
	save_data.store_line(to_json(formulae_temp))
	save_data.close()
	#update current length
	emit_signal("favorites_changed")


