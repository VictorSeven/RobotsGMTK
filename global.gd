extends Node

var current_scene = null
var last_level = 3 #Number of levels


func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child( root.get_child_count() -1 )


#Reload current level, in case of death
func retry_level():
	music.change_music()
	goto_scene("res://core/creditos.tscn")
	
func start():
	music.change_music()
	goto_scene("res://levels/level-2.tscn")


#Get the current level, and load next
func load_next_level():
	var level_index = int(current_scene.filename[-6])
	level_index += 1
	
	if level_index > last_level:
		music.change_music()
		goto_scene("res://core/creditos.tscn")
	else:
		goto_scene("res://levels/level-" + str(level_index) + ".tscn")

#Call the load to other scene when possible
func goto_scene(path):
	call_deferred("_deferred_goto_scene", path)


func _deferred_goto_scene(path):

	# Immediately free the current scene,
	# there is no risk here.
	current_scene.free()

	# Load new scene
	var s = ResourceLoader.load(path)

	# Instance the new scene
	current_scene = s.instance()

	# Add it to the active scene, as child of root
	get_tree().get_root().add_child(current_scene)

	# optional, to make it compatible with the SceneTree.change_scene() API
	get_tree().set_current_scene( current_scene )


