@tool
extends Control
class_name VTabBar

signal tab_clicked(tab :int)

@export var current_tab = 0

var tab_container := VBoxContainer.new()
var tab_count := 0
var button_group := ButtonGroup.new()

func _ready():
    if tab_container is VBoxContainer:
        tab_container.alignment = BoxContainer.ALIGNMENT_BEGIN
        tab_container.anchors_preset = PRESET_LEFT_WIDE
        add_child(tab_container)
        tab_container.show()


func add_tab(title :String):
    var tab_button = Button.new()
    tab_button.text = title
    tab_button.toggle_mode = true
    tab_button.button_group = button_group
    tab_button.connect("pressed", func(): tab_clicked.emit(tab_count))
    tab_count += 1
    tab_container.add_child(tab_button)


func clear_tabs():
    tab_count = 0
    
    for child in tab_container.get_children():
        if child:
            tab_container.remove_child(child)
            child.queue_free()


func get_tab_title(tab_idx :int) -> String:
    var children = tab_container.get_children()
    return children[tab_idx].text


func remove_tab(tab_idx: int):
    var children = tab_container.get_children()
    
    if children == null:
        return
    
    if tab_idx > tab_count:
        return
    
    tab_count -= 1
    tab_container.remove_child(children[tab_idx])
    children[tab_idx].queue_free()
