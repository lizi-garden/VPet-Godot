extends CanvasLayer

signal exit
signal eat(food :Texture2D)
signal drink(drink :Texture2D)
signal gift(gift :Texture2D)

signal level_value_changed(value :int)
signal money_value_changed(value :int)
signal health_value_changed(value :int)
signal hunger_value_changed(value :int)
signal thirsty_value_changed(value :int)

@export var level_value := 1:
    set(value):
        level_value_changed.emit(value)
        main_ui.level_value_label_update(value)
        level_value = value

@export var money_value := 1_000:
    set(value):
        money_value_changed.emit(value)
        main_ui.money_value_label_update(value)
        money_value = value

@export var health_value := 500_000:
    set(value):
        health_value_changed.emit(value)
        main_ui.health_progress_bar_update(value)
        health_value = value

@export var hunger_value := 500_000:
    set(value):
        hunger_value_changed.emit(value)
        main_ui.hunger_progress_bar_update(value)
        hunger_value = value

@export var thirsty_value := 500_000:
    set(value):
        thirsty_value_changed.emit(value)
        main_ui.thirsty_progress_bar_update(value)
        thirsty_value = value

@onready var main_ui = $MainUI
@onready var right_click_menu = $RightClickMenu
@onready var exit_button = $ExitButton
@onready var exit_dialog = $ExitDialog


var setting_window  :Window
var items_window    :Window

var viewport_pos    :Vector2
var viewport_size   :Vector2


func _ready():
    main_ui.connect("custom_button_pressed", func(): _on_show_setting_window("custom"))
    main_ui.connect("data_button_pressed", func(): _on_show_setting_window("data"))
    exit_button.connect("pressed", func(): exit_dialog.show())
    exit_dialog.connect("confirmed", func(): exit.emit())
    
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
        "exit":     exit_dialog.show()


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



