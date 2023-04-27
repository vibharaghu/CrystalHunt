extends Control

onready var crystalText = get_node("Crystal")

func update_crystal_text(crystal):
	crystalText.text = "Crystals: " + str(crystal)
	
	
