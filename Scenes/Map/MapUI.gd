# Author: Kurt Ian Khalid I. Israel
# License: 0BSD
# Permission to use, copy, modify, and/or distribute this software for any purpose with or without fee is hereby granted.

# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

extends VirusGenerator

onready var money_amount = $Money/Account

var button = 0

func _ready():
	mass_produced_vaccines("hello", [1, 2, 3, 4, 5])
	mass_produced_vaccines("world", [1, 2, 3, 4, 5])
	mass_produced_vaccines("alam", [1, 2, 3, 4, 5])
	mass_produced_vaccines("mo", [1, 2, 3, 4, 5])
	mass_produced_vaccines("ba", [1, 2, 3, 4, 5])
	mass_produced_vaccines("kung", [1, 2, 3, 4, 5])
	mass_produced_vaccines("bakit", [1, 2, 3, 4, 5])
	mass_produced_vaccines("mahal", [1, 2, 3, 4, 5])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	money_amount.text = "PHP %s" % [Profile.format_money(Profile.money)]

func disable_region():
	$Buttons.get_children()[button].disabled = true

func mass_produced_vaccines(vaccineName, bundleSequences):
	var save_game = File.new()
	if not save_game.file_exists("user://AvailableVaccines.save"):
		var dict = {}
		dict[vaccineName] = bundleSequences
		save_game.open("user://AvailableVaccines.save", File.WRITE)
		save_game.store_line(to_json(dict))
		save_game.close()
	else:
		save_game.open("user://AvailableVaccines.save", File.READ)
		var dict = parse_json(save_game.get_line())
		save_game.close()
		save_game.open("user://AvailableVaccines.save", File.WRITE)
		dict[vaccineName] = bundleSequences
		save_game.store_line(to_json(dict))
		save_game.close()
	pass

func init_map():
	$RegionHudPopup.load_vaccines()

func initialize_regions():
	var save_game = File.new()
	var outer_dict = {}
	
	for i in range(17):
		var in_dict = {}
		var sequences  = []
		in_dict["disabled"] = false
		in_dict["waitTime"] = OS.get_unix_time()
		for j in range(5):
			sequences.append(generateSymptom(10))
		in_dict["initsequences"] = sequences
		outer_dict[i] = in_dict
	save_game.open("user://Regions.save", File.WRITE)
	save_game.store_line(to_json(outer_dict))
	save_game.close()
	
		
		
		
