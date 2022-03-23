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

signal formula_loaded_to_cauldron #indicates that the load to cauldron button is pressed


onready var formula_file_path = "user://formuladirectory.save"
onready var favorites_file_path = "user://favoritesdirectory.save"

var is_new_game: bool
#Directory items---------------------------
var curr_dir_length = 0 #size of directory
var mass_prod_price = 200000 #Task: randomize
#End of Directory items--------------------


# Called when the node enters the scene tree for the first time.
func _ready():
	
	var init_formula = File.new()
	if not init_formula.file_exists(formula_file_path):
		#Create Archive and favorites file
		init_formula.open(formula_file_path, File.READ_WRITE)
		init_formula.close()

		var init_favorites = File.new()
		init_favorites.open(favorites_file_path, File.READ_WRITE)
		init_favorites.close()
		return 0 #indicates new game
	else:
		#Load presaved formula
		initialize_formula_book() 
		return 1 #indicates pre-existing game
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
# The formula name and state are set here.
func _process(delta):
	pass

#Sets up the favorites page's formula
func initialize_formula_book():
	var file = File.new()
	file.open(favorites_file_path, File.READ)
	var index = 1
	while not file.eof_reached(): # iterate through all lines until the end of file is reached
		var slot_path = "FormulaBookControl/Formula"+str(index)+"/Name"
		var dict = parse_json(file.get_line())
		get_node(slot_path).text=dict["Name"]
		get_node(slot_path).is_occupied=true
		index += 1
	file.close()
	
		
#Go to Cauldron Subsystem when the button is pressed	
func _on_BackButton_pressed():
	get_tree().change_scene("res://Scenes/Cauldron/Cauldron.tscn")

# Archive Page appears when the Archive icon is pressed from the Favorites page
func _on_ArchiveIcon_pressed():
	get_tree().change_scene("res://Scenes/FormulaBook/Archive Page/ArchivePage.tscn")
	

# This function saves a Formula data to the Formula Directory file. 
# Can be called by the cauldron to save newly mixed formula by calling FormulaBook.save_formula()
# check the link below to see where your OS saves profile.save
# https://docs.godotengine.org/en/stable/tutorials/io/data_paths.html#accessing-persistent-user-data
func add_to_formulabook(formula_name:String,formula_description:String,components:Array):
	var dict_to_save = {	#can be checked if occpied if it is in the favorites file
		"ID":curr_dir_length,
		"Name": formula_name,
		"Description": formula_description,
		"MassProducePrice": mass_prod_price, #Task: create a Randomize function for mass produce price, or something based to it's components price
		"Components": components
	}
	
	#Append the formula at the end of the file
	var save_data = File.new()
	save_data.open(formula_file_path, File.READ_WRITE)
	save_data.seek_end()
	save_data.store_string("\n")
	save_data.store_line(to_json(dict_to_save))
	save_data.close()
	#update current length
	curr_dir_length= curr_dir_length+1
	
# this function loads the profile data
# if there is no profile data, then it just returns
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
		save_fav.store_string("\n")
		save_fav.store_line(to_json(dict)) #save the data for easier loading
		save_fav.close()
		
#Returns if the formula occupies a slot in the favorites page
func is_favorite_formula(id:int):
	var dict=load_a_formulae(id,favorites_file_path)
	if dict!=0 || dict!=1:
		return true #A formula in the favorites formula page
	return false

