class_name GBLevel
extends Node2D

@export var Object_Parent : Node2D

func _ready() -> void:
	Globals.gb_objects = Object_Parent
