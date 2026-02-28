extends Control

@export var restart_scene_path := "res://scenes/world/level_01.tscn"

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("restart"):
		get_tree().change_scene_to_file(restart_scene_path)
