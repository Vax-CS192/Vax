# Author: John Henry A. Galino
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


# How to use:
# Call Profile.<var_name> anywhere you need the data
# You can also set it directly
var money = 1000000
var president_name: String
var is_new_game = true


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# This function places commas in your money
func format_money(money: int):
	var money_string = str(money)
	var place = len(money_string) % 3
	var result = ""
	
	if money >= 0:
		for i in range(0, len(money_string)):
			if i != 0 and i % 3 == place:
				result += ","
			result += money_string[i]
		
		return result
	else:
		for i in range(1, len(money_string)):
			if i != 0 and i % 3 == place:
				result += ","
			result += money_string[i]
		
		return result

# this function saves the profile data
# check the link below to see where your OS saves profile.save
# https://docs.godotengine.org/en/stable/tutorials/io/data_paths.html#accessing-persistent-user-data
func save_data():
	var dict_to_save = {
		"money": money,
		"president_name": president_name,
		"is_new_game": is_new_game
	}
	var save_game = File.new()
	save_game.open("user://profile.save", File.WRITE)
	save_game.store_line(to_json(dict_to_save))
	save_game.close()
	
# this function loads the profile data
# if there is no profile data, then it just returns
func load_data():
	var save_game = File.new()
	if not save_game.file_exists("user://profile.save"):
		is_new_game = true
		return
	else:
		is_new_game = false
		save_game.open("user://profile.save", File.READ)
		var dict = parse_json(save_game.get_line())
		money = dict["money"]
		president_name = dict["president_name"]
		is_new_game = dict["is_new_game"]
		save_game.close()

# initial save state
func save_president_name():
	var save_game = File.new()
	
	var initial_dict_save = {
		"president_name" : president_name
	}
	save_game.open("user://profile.save", File.WRITE)
	save_game.store_line(to_json(initial_dict_save))
	save_game.close()
	
func clear_user_directory():
	var dir = Directory.new()
	dir.remove("user://profile.save")
	dir.remove("user://formuladirectory.save")
	dir.remove("user://favoritesdirectory.save")
	dir.remove("user://AvailableVaccines.save")
