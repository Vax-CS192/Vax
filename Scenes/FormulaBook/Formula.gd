extends Control

export var is_occupied=false
var occupied_icon=preload("res://Assets/Formula Book/Occupied Formula.png")
var empty_icon=preload("res://Assets/Formula Book/Empty Formula.png")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	is_occupied=false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Icon.texture_normal=empty_icon
	if is_occupied==true:
		$Icon.texture_normal=occupied_icon
		
