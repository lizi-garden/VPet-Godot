extends Node

@onready var ui = $UI
@onready var pet = $Pet


func _ready():
    ui.connect("exit", pet.vup.shutdown)
    pass
