extends Control


# Declare member variables here. Examples:
var region = 100
var regioninfo = {}

onready var timerField = get_child(0)
onready var MapUI = get_parent().get_parent()
var first = false

var MoneyBag = preload("res://Scenes/Map/MoneyBag.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if region != 100:
		if regioninfo["waitTime"] > OS.get_unix_time():
			var remainingTime = regioninfo["waitTime"] - OS.get_unix_time()
			var secs = fmod(remainingTime, 60)
			var mins = fmod(remainingTime, 3600)/60
			var elapsedTime = "%02d:%02d" % [mins, secs]
			timerField.text = elapsedTime
			self.show()
		else:
			if regioninfo["collect"] and !first:
				instantiate_moneyBag()
				first = true
			MapUI.update_dict_info(region, regioninfo)
			self.hide()

func set_region(index):
	region = index
	regioninfo = get_parent().get_parent().get_dict_info(index)

func instantiate_moneyBag():
	var MBInstance = MoneyBag.instance()
	MBInstance.set_position(self.rect_global_position)
	MBInstance.set_value(regioninfo["reward"], region)
	get_parent().get_parent().get_child(5).add_child(MBInstance)
