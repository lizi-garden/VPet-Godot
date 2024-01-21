@tool
extends HBoxContainer
class_name VTabContainer

@export var current_tab := 1

var v_tab_bar := VTabBar.new()
var tab_count := 0


func _init():
    if v_tab_bar is VTabBar:
        add_child(v_tab_bar)


func _ready():
    if v_tab_bar is VTabBar:
        v_tab_bar.connect("tab_clicked", _on_tab_bar_click)
    
    for child in get_children():
        if child is Container:
            child.size_flags_horizontal = Control.SIZE_EXPAND_FILL
            v_tab_bar.add_tab(child.name)

    var count = 0
    for child in get_children():
        if child is Container:
            if count == current_tab:    child.show()
            else:                       child.hide()
            count += 1


func get_tab_title(tab_idx :int) -> String:
    return v_tab_bar.get_tab_title(tab_idx)


func _on_tab_bar_click(tab :int):
    pass
