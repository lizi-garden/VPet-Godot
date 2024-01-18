extends Node
class_name FSM

signal _enter(to :String)
signal _exit(from :String)


@export var empty_state :Node

var current_state   :Node
var states: Dictionary = {}


func _ready():
    for child in get_children():
        if child is Node:
            states[child.name.to_lower()] = child
    
    if empty_state:
        _enter.emit(empty_state.name)
        current_state = empty_state


func _on_child_transitioned(state, new_state_name):
    if state != current_state:
        return
    
    var new_state = states.get(new_state_name.to_lower())
    if !new_state:
        return
    
    if current_state:
        _exit.emit(new_state_name)
    
    _enter.emit(new_state_name)
    current_state = new_state


func change_state_to(new_state_name :String):
    _on_child_transitioned(current_state, new_state_name)
