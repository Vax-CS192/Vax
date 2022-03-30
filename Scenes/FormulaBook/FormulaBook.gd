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

signal favorites_changed() #indicates that the there has been some changes in the favorites file
#signal fav_count_changed(fav_count)

onready var formula_file_path = "user://formuladirectory.save"
onready var favorites_file_path = "user://favoritesdirectory.save"
#onready var formulaPage = preload("res://Scenes/FormulaBook/Formula Page/FormulaPage.tscn").instance()


var is_new_game: bool
#Directory items---------------------------
var dict_to_save = {	#can be checked if occpied if it is in the favorites file
		"ID":null,
		"Name": null,
		"Description": null,
		"MassProducePrice": null, #Task: create a Randomize function for mass produce price, or something based to it's components price
		"Components": null
	}
var curr_dir_length = 0 #size of directory
var mass_prod_price = 200000 #Task: randomize
#End of Directory items--------------------

#List of Favorites
var favorites = []

# Called when the node enters the scene tree for the first time.
func _ready():
	print("creae files")
	var init_formula = File.new()
	init_formula.open(formula_file_path, File.WRITE)
	init_formula.close()
		
	var init_favorites = File.new()
	init_favorites.open(favorites_file_path, File.WRITE)
	init_favorites.close()
	
# Called when the favorites file is changed
func _on_FormulaBook_favorites_changed():
	var favorites_formula = File.new()
	if favorites_formula.file_exists(formula_file_path):
		initialize_formula_book() 
	
#Sets up the favorites page's formula
func initialize_formula_book():
	var slot_path = ""
	var file = File.new()
	file.open(favorites_file_path, File.READ)
	var index = 1
	while not file.eof_reached(): # iterate through all lines until the end of file is reached
		print(index)
		if index>10:
			break
		slot_path = "FormulaBookControl/Formula"+str(index)
		var dict = parse_json(file.get_line())
		favorites.append(dict)
		if dict!=null:
			get_node(slot_path+"/Name").text=dict["Name"]
			get_node(slot_path).is_occupied=true
			index += 1
	file.close()

	if index<=10: #set occupied to false
		while index<=10:
			slot_path = "FormulaBookControl/Formula"+str(index)
			get_node(slot_path).is_occupied=false
			get_node(slot_path+"/Name").text=""
			index+=1
	
	
		
#Go to Cauldron Subsystem when the button is pressed	
func _on_BackButton_pressed():
	self.hide()
	#get_node("/root/Session").hideAndChangeSceneTo(PersistentScenes.formulaBook,PersistentScenes.cauldron)
	PersistentScenes.cauldron.draw()
	
# Archive Page appears when the Archive icon is pressed from the Favorites page
func _on_ArchiveIcon_pressed():
	$ArchivePage.show()
	#get_tree().change_scene("res://Scenes/FormulaBook/Archive Page/ArchivePage.tscn")
	

# This function saves a Formula data to the Formula Directory file. 
# Can be called by the cauldron to save newly mixed formula by calling FormulaBook.save_formula()
# check the link below to see where your OS saves profile.save
# https://docs.godotengine.org/en/stable/tutorials/io/data_paths.html#accessing-persistent-user-data
func add_to_formulabook(formula_name:String,formula_description:String,components:Array):
	dict_to_save = {	#can be checked if occpied if it is in the favorites file
		"ID":curr_dir_length+1, #so it starts with 1
		"Name": formula_name,
		"Description": formula_description,
		"MassProducePrice": mass_prod_price, #Task: create a Randomize function for mass produce price, or something based to it's components price
		"Components": components
	}
	
	#Append the formula at the end of the file
	var save_data = File.new()
	save_data.open(formula_file_path, File.READ_WRITE)
	save_data.seek_end()
	save_data.store_line(to_json(dict_to_save))
	save_data.close()
	#update current length
	curr_dir_length=+1
	emit_signal("archives_changed")
	
# this function loads the profile data
# if there is no profile data, then it just returns nothing
func load_a_formulae(id:int,file_path:String):
	var save_formula = File.new()
	if not save_formula.file_exists(file_path):
		is_new_game = true
		return 0 #indicates new game
	else:
		is_new_game = false
		save_formula.open(file_path, File.READ)
		var index = 1
		while not save_formula.eof_reached(): # iterate through all lines until the end of file is reached
			var dict = parse_json(save_formula.get_line())
			if dict["ID"]==id:
				return dict
			index += 1
		save_formula.close()
		return 1 #indicates that it is a non-existing formula

#Adds a selected formula from the archives to the favorites file
func set_as_favorite(id:int):
	var dict=load_a_formulae(id,formula_file_path)
	if dict!=0 || dict!=1:
		dict["is_occupied"]=true
		var save_fav = File.new()
		save_fav.open(favorites_file_path, File.READ_WRITE)
		save_fav.seek_end()
		save_fav.store_line(to_json(dict)) #save the data for easier loading
		save_fav.close()
		
#Returns if the formula occupies a slot in the favorites page
func is_favorite_formula(id:int):
	var dict=load_a_formulae(id,favorites_file_path)
	if dict!=0 || dict!=1:
		return true #A formula in the favorites formula page
	return false

#Go to corresponding Cauldron Subsystem when the button is pressed. Task: Merge into one method if kaya
func _on_Formula_pressed(fp_slot):
	var formulae_details = favorites[fp_slot-1] #fp_slot names are 1-index
	$FormulaPage.load_formula_parameters(formulae_details)
	#formulaPage.set_visible()
	#get_tree().change_scene_to(formulaPage)
	$FormulaPage.show()

#Hard coded since we need to know the button name
func _on_Formula1_pressed():
	if $FormulaBookControl/Formula1.is_occupied==true:
		_on_Formula_pressed(1)
	else:
		pass

func _on_Formula2_pressed():
	if $FormulaBookControl/Formula2.is_occupied==true:
		_on_Formula_pressed(2)
	else:
		pass

func _on_Formula3_pressed():
	if $FormulaBookControl/Formula3.is_occupied==true:
		_on_Formula_pressed(3)
	else:
		pass

func _on_Formula4_pressed():
	if $FormulaBookControl/Formula4.is_occupied==true:
		_on_Formula_pressed(4)
	else:
		pass

func _on_Formula5_pressed():
	if $FormulaBookControl/Formula5.is_occupied==true:
		_on_Formula_pressed(5)
	else:
		pass

func _on_Formula6_pressed():
	if $FormulaBookControl/Formula6.is_occupied==true:
		_on_Formula_pressed(6)
	else:
		pass

func _on_Formula7_pressed():
	if $FormulaBookControl/Formula7.is_occupied==true:
		_on_Formula_pressed(7)
	else:
		pass
		
func _on_Formula8_pressed():
	if $FormulaBookControl/Formula8.is_occupied==true:
		_on_Formula_pressed(8)
	else:
		pass

func _on_Formula9_pressed():
	if $FormulaBookControl/Formula9.is_occupied==true:
		_on_Formula_pressed(9)
	else:
		pass

func _on_Formula10_pressed():
	if $FormulaBookControl/Formula10.is_occupied==true:
		_on_Formula_pressed(10)
	else:
		pass



#save changes to favorites file
func save_favorites_data():
	#create new file
	var remove_data = File.new()
	remove_data.remove_meta(favorites_file_path)
	
	var save_data = File.new()
	save_data.open(favorites_file_path, File.WRITE)
	for formulae in favorites:
		if formulae!=null:
			print("writing...", formulae)
			#save_data.seek_end()
			save_data.store_line(to_json(formulae))
	save_data.close()
	#update current length
	#update current length
	emit_signal("favorites_changed")
	
#delete a formula in the favorites fila
func _on_FormulaPage_delete_formulae(id):
	var index=0
	for formulae in favorites:
		if formulae["ID"]==id:
			favorites.remove(index)
			break
		index+=1
	save_favorites_data()	
	$FormulaPage.hide()
	curr_dir_length-=1
	
#updates the deetails of the edited data
func _on_FormulaPage_formula_deets_edited(formula_parameters):
	var index=0
	for formulae in favorites:
		if formulae["ID"]==formula_parameters["ID"]:
			print("EDITED TO",formula_parameters)
			favorites[index]=formula_parameters
			break
		index+=1
	save_favorites_data()
	$FormulaPage.hide()

#directly shows the formula book screen which is hidden by default
func draw():
	get_node("/root/Session").hideAndChangeSceneTo(self, PersistentScenes.formulaBook)
	get_node("/root/Session").hideAndChangeSceneTo(self, PersistentScenes.formulaBook)

#Hides the Archive page when back button from the archive page is pressed
func _on_ArchivePage_archives_closed():
	$ArchivePage.hide()



