extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

class_name VirusGenerator

var alphabet = {
	"0": "t",
	"1": "a",
	"2": "c",
	"3": "g",
}

func generateSymptom(length: int) -> String:
	randomize()
	var symp = ""
	for i in range(length):
		var random = round(rand_range(0.0, 3.0))
		symp += alphabet.get(String(random))
	return symp

func generateBundles() -> Array:
	var baseSymp: String = generateSymptom(10)
	var genBund1 = baseSymp.substr(0,5) + generateSymptom(5)
	var genBund2 = baseSymp.substr(0,6) + generateSymptom(4)
	var genBund3 = baseSymp.substr(0,7) + generateSymptom(3)
	return [baseSymp, genBund1, genBund2, genBund3]
