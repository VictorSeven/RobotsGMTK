extends Area2D


#Show it with a base or not
export (int, "Base", "NoBase") var base = 0

#The node to act over when this computer is activated


# Called when the node enters the scene tree for the first time.
func _ready():
	
	#Show base or not
	if base == 0:
		$legs.show()
	else:
		$legs.hide()
	
	#We do not need any specific process
	set_process(false)


#Do the action when activated
func act():
	get_tree().call_group("barreras", "change_activated")
