extends VirusGenerator


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var mainMenu = load("res://Scenes/MainMenu/MainMenu.tscn")
var bundles1 = generateBundles()
var bundles2 = generateBundles()
var bundles3 = generateBundles()
var bundles4 = generateBundles()
var bundles5 = generateBundles()

signal entered

# Called when the node enters the scene tree for the first time.
func _ready():
	self.connect("entered", get_node("/root/PersistentScenes"), "_on_ready_Session")
	emit_signal("entered")
	mainMenu = mainMenu.instance()
	self.add_child(mainMenu)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func changeSceneTo(currentScene: Node, nextScene: CanvasItem):
	nextScene.show()
	currentScene.queue_free()
	self.add_child(nextScene)
	
func hideAndChangeSceneTo(current: CanvasItem, nextScene: Node):
	current.hide() 
	self.add_child(nextScene)
	

