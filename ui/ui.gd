extends CanvasLayer

signal exit
signal eat(food :Texture2D)
signal drink(drink :Texture2D)


@onready var right_click_menu = $RightClickMenu
@onready var main_ui = $MainUI

var setting_window  :Window
var items_window    :Window

var viewport_pos    :Vector2
var viewport_size   :Vector2


func _ready():
    main_ui.connect("custom_button_pressed", func(): _on_show_setting_window("custom"))
    main_ui.connect("data_button_pressed", func(): _on_show_setting_window("data"))
    
    viewport_size = get_viewport().size
    right_click_menu.hide()


func _unhandled_input(event):
    if event is InputEventMouseButton:
        if event.button_index == MOUSE_BUTTON_LEFT and event.double_click:
            main_ui.visible = !main_ui.visible
        
        if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
            viewport_pos = get_tree().get_root().position
            right_click_menu.position = viewport_pos + event.global_position
            right_click_menu.show()


func _on_right_click_menu_index_pressed(index :int):
    match right_click_menu.get_item_text(index).to_lower():
        "setting":  _on_show_setting_window()
        "dock":     main_ui.visible = !main_ui.visible
        "exit":     exit.emit()


func _on_system_button_pressed(tab_name):
    match tab_name:
        "system":       _on_show_setting_window("system")
        "screenshot":   pass
        "recording":    pass


func _on_show_setting_window(tab_name :String = "data"):
    if not has_node("SettingWindow"):
        setting_window = preload("res://ui/setting_window.tscn").instantiate()
        add_child(setting_window)
    else:
        setting_window = get_node("SettingWindow")
    
    if tab_name == "":
        tab_name = "data"
    
    setting_window.switch_tab(tab_name)
    setting_window.show()


func _on_show_items_window(tab_name :String = "food"):
    if not has_node("ItemsWindow"):
        items_window = preload("res://ui/items_window.tscn").instantiate()
        add_child(items_window)
    else:
        items_window = get_node("ItemsWindow")
    
    if tab_name == "":
        tab_name = "food"
    
    items_window.switch_tab(tab_name)
    items_window.show()



