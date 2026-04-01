class_name LevelMusic
extends Node

@export var music_name : String = "Level 1 Music"


func _ready() -> void:
	Globals.gb_audio.play_music(music_name)
