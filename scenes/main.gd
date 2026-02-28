# res://scenes/main/Main.gd
extends Control

@export var level_scene_path := "res://scenes/world/Level_01.tscn"

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("start"): # Enter/Space per assignment :contentReference[oaicite:0]{index=0}
		get_tree().change_scene_to_file(level_scene_path)
