extends Node

signal exit
signal setting

func _on_right_click_menu_index_pressed(index):
    match index:
        0: setting.emit()
        1: exit.emit()
    pass
