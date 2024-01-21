extends Node

signal exit
signal eat(food :Texture2D)
signal drink(drink :Texture2D)


@onready var right_click_menu = $MainUI/RightClickMenu
@onready var main_ui = $MainUI


var setting_window = preload("res://ui/setting_window.tscn").instantiate()
var items_window = preload("res://ui/items_window.tscn").instantiate()


func _ready():
    main_ui.connect("popup_items_window", _on_popup_items_window)


func _on_right_click_menu_index_pressed(index :int):
    match right_click_menu.get_item_text(index).to_lower():
        "setting":  setting_window.show_window()
        "exit":     exit.emit()


func _on_popup_items_window(tab_name :String):
    if not has_node("ItemsWindow"):
        items_window = preload("res://ui/items_window.tscn").instantiate()
        add_child(items_window)
    
    items_window.switch_tab(tab_name)
    pass
