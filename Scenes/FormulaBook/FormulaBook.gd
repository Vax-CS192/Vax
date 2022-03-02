extends Node

var path

func _process(delta):
	#Set Formula State and Names
	$FormulaBookControl/Formula1.is_occupied=true
	get_node("FormulaBookControl/Formula1/Name").text="NGALAN"
	$FormulaBookControl/Formula2.is_occupied=true
	get_node("FormulaBookControl/Formula2/Name").text="MARAHUYO"
	$FormulaBookControl/Formula3.is_occupied=true
	get_node("FormulaBookControl/Formula3/Name").text="PAYZER"
	$FormulaBookControl/Formula4.is_occupied=true
	get_node("FormulaBookControl/Formula4/Name").text="SAYA"
	$FormulaBookControl/Formula5.is_occupied=true
	get_node("FormulaBookControl/Formula5/Name").text="SIGLA"
	$FormulaBookControl/Formula6.is_occupied=true
	get_node("FormulaBookControl/Formula6/Name").text="LIGAYA"
	$FormulaBookControl/Formula7.is_occupied=true
	get_node("FormulaBookControl/Formula7/Name").text="MANAWARI"
	$FormulaBookControl/Formula8.is_occupied=true
	get_node("FormulaBookControl/Formula8/Name").text="J&J"


#Go to Lab Subsystem when the button is pressed	
func _on_BackButton_pressed():
	get_tree().change_scene("res://Scenes/Lab/Lab.tscn")
