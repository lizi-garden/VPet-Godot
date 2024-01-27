extends MarginContainer

signal items_button_pressed(tab_name :String)
signal data_button_pressed
signal custom_button_pressed
signal system_button_pressed(tab_name :String)


func _ready():
    main_ui_init()

## Data Panel Init

@onready var level_value_label = $VBoxContainer/DataPanel/MarginContainer/VBoxContainer/LevelContainer/Value
@onready var money_value_label = $VBoxContainer/DataPanel/MarginContainer/VBoxContainer/MoneyContainer/Value
@onready var health_progress_bar = $VBoxContainer/DataPanel/MarginContainer/VBoxContainer/HealthContainer/ProgressBar
@onready var hunger_progress_bar = $VBoxContainer/DataPanel/MarginContainer/VBoxContainer/HungerContainer/ProgressBar
@onready var thirsty_progress_bar = $VBoxContainer/DataPanel/MarginContainer/VBoxContainer/ThirstyContainer/ProgressBar

func level_value_label_update(value :int):
    level_value_label.text = "lv." + str(value)

func money_value_label_update(value :int):
    money_value_label.text = str(value) + "RMB"

func health_progress_bar_update(value :int):
    health_progress_bar.value = value
    
func hunger_progress_bar_update(value :int):
    hunger_progress_bar.value = value

func thirsty_progress_bar_update(value :int):
    thirsty_progress_bar.value = value


## Main UI Init

@onready var filler_panel = $VBoxContainer/FillerPanel
@onready var data_panel = $VBoxContainer/DataPanel
@onready var custom_panel = $VBoxContainer/CustomPanel
@onready var menu_container = $VBoxContainer/MenuContainer
@onready var items_menu = $VBoxContainer/MenuContainer/ItemsMenu
@onready var system_menu = $VBoxContainer/MenuContainer/SystemMenu
@onready var dock_container = $VBoxContainer/DockContainer
@onready var items_button = $VBoxContainer/DockContainer/HBoxContainer/ItemsButton
@onready var data_button = $VBoxContainer/DockContainer/HBoxContainer/DataButton
@onready var custom_button = $VBoxContainer/DockContainer/HBoxContainer/CustomButton
@onready var system_button = $VBoxContainer/DockContainer/HBoxContainer/SystemButton

var viewport_size :Vector2

func main_ui_init():
    filler_panel.connect("mouse_entered", display_init)
    items_button.connect("mouse_entered", items_menu_show)
    data_button.connect("mouse_entered", data_panel_show)
    custom_button.connect("mouse_entered", custom_panel_show)
    system_button.connect("mouse_entered", system_menu_show)

    viewport_size = get_viewport().size
    dock_container.custom_minimum_size = Vector2(0, viewport_size.y / 5)

    for child in items_menu.get_children():
        if child is Button:
            child.connect("pressed", func(): items_button_pressed.emit(child.text.to_lower()))
            
    for child in system_menu.get_children():
        if child is Button:
            child.connect("pressed", func(): system_button_pressed.emit(child.text.to_lower()))
    
    items_button.connect("pressed", func(): items_button_pressed.emit(items_button.text.to_lower()))
    data_button.connect("pressed", func(): data_button_pressed.emit())
    custom_button.connect("pressed", func(): custom_button_pressed.emit())
    system_button.connect("pressed", func(): system_button_pressed.emit(system_button.text.to_lower()))
    display_init()

func display_init():
    filler_panel.size_flags_stretch_ratio = 4
    filler_panel.show()
    data_panel.hide()
    custom_panel.hide()
    menu_container.hide()
    items_menu.hide()
    system_menu.hide()


func items_menu_show():
    filler_panel.size_flags_stretch_ratio = 3
    filler_panel.show()
    data_panel.hide()
    custom_panel.hide()
    menu_container.show()
    items_menu.show()
    system_menu.hide()


func data_panel_show():
    filler_panel.size_flags_stretch_ratio = 3
    filler_panel.show()
    data_panel.show()
    custom_panel.hide()
    menu_container.hide()
    items_menu.hide()
    system_menu.hide()


func custom_panel_show():
    filler_panel.size_flags_stretch_ratio = 3
    filler_panel.show()
    data_panel.hide()
    custom_panel.show()
    menu_container.hide()
    items_menu.hide()
    system_menu.hide()


func system_menu_show():
    filler_panel.size_flags_stretch_ratio = 3
    filler_panel.show()
    data_panel.hide()
    custom_panel.hide()
    menu_container.show()
    items_menu.hide()
    system_menu.show()
