extends CanvasLayer

signal exit
signal eat(food :Texture2D)
signal drink(drink :Texture2D)


@onready var right_click_menu = $RightClickMenu
@onready var main_ui = $MainUI


var setting_window = preload("res://ui/setting_window.tscn").instantiate()
var items_window = preload("res://ui/items_window.tscn").instantiate()

var viewport_pos    :Vector2
var viewport_size   :Vector2


func _ready():
    main_ui.connect("popup_items_window", _on_show_items_window)
    
    viewport_size = get_viewport().size
    right_click_menu.hide()


func _unhandled_input(event):
    if event is InputEventMouseButton:
        if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
            viewport_pos = get_tree().get_root().position
            right_click_menu.position = viewport_pos + event.global_position
            right_click_menu.show()


func _on_right_click_menu_index_pressed(index :int):
    match right_click_menu.get_item_text(index).to_lower():
        "setting":  setting_window.show_window()
        "exit":     exit.emit()


func _on_show_items_window(tab_name :String = "food"):
    if not has_node("ItemsWindow"):
        add_child(items_window)
    
    items_window.switch_tab(tab_name)
    items_window.show()
    pass
