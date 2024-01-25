extends MarginContainer

signal items_button_pressed(tab_name :String)
signal data_button_pressed
signal custom_button_pressed
signal system_button_pressed(tab_name :String)

var viewport_size :Vector2

func _ready():
    filler_panel.connect("mouse_entered", initial_show)
    items_button.connect("mouse_entered", items_menu_show)
    data_button.connect("mouse_entered", data_panel_show)
    custom_button.connect("mouse_entered", custom_panel_show)
    system_button.connect("mouse_entered", system_menu_show)
    
    viewport_size = get_viewport().size
    items_button.custom_minimum_size = Vector2(0, viewport_size.y / 5 + 5)
    data_button.custom_minimum_size = Vector2(0, viewport_size.y / 5 + 5)
    custom_button.custom_minimum_size = Vector2(0, viewport_size.y / 5 + 5)
    system_button.custom_minimum_size = Vector2(0, viewport_size.y / 5 + 5)

    for child in items_menu.get_children():
        if child is Button:
            child.connect("pressed", func(): items_button_pressed.emit(child.name.to_lower()))
            
    for child in system_menu.get_children():
        if child is Button:
            child.connect("pressed", func(): system_button_pressed.emit(child.name.to_lower()))
    
    items_button.connect("pressed", func(): items_button_pressed.emit(items_button.text.to_lower()))
    data_button.connect("pressed", func(): data_button_pressed.emit())
    custom_button.connect("pressed", func(): custom_button_pressed.emit())
    system_button.connect("pressed", func(): system_button_pressed.emit(system_button.text.to_lower()))
    initial_show()


@onready var filler_panel = $VBoxContainer/FillerPanel
@onready var h_box_container = $VBoxContainer/HBoxContainer
@onready var items_menu = $VBoxContainer/HBoxContainer/ItemsContainer/ItemMenu
@onready var items_filler = $VBoxContainer/HBoxContainer/ItemsContainer/Panel
@onready var items_button = $VBoxContainer/HBoxContainer/ItemsContainer/Button
@onready var data_panel = $VBoxContainer/DataShow
@onready var data_filler = $VBoxContainer/HBoxContainer/DataContainer/Panel
@onready var data_button = $VBoxContainer/HBoxContainer/DataContainer/Button
@onready var custom_panel = $VBoxContainer/CustomShow
@onready var custom_filler = $VBoxContainer/HBoxContainer/CustomContainer/Panel
@onready var custom_button = $VBoxContainer/HBoxContainer/CustomContainer/Button
@onready var system_menu = $VBoxContainer/HBoxContainer/SystemContainer/SystemMenu
@onready var system_filler = $VBoxContainer/HBoxContainer/SystemContainer/Panel
@onready var system_button = $VBoxContainer/HBoxContainer/SystemContainer/Button


func initial_show():
    filler_panel.size_flags_stretch_ratio = 4
    filler_panel.show()
    h_box_container.size_flags_stretch_ratio = 1
    h_box_container.show()
    
    items_menu.hide()
    items_filler.hide()
    items_button.show()
    
    data_panel.hide()
    data_filler.hide()
    data_button.show()
    
    custom_panel.hide()
    custom_filler.hide()
    custom_button.show()
    
    system_menu.hide()
    system_filler.hide()
    system_button.show()


func items_menu_show():
    filler_panel.size_flags_stretch_ratio = 3
    filler_panel.show()
    h_box_container.size_flags_stretch_ratio = 2
    h_box_container.show()
    
    items_menu.show()
    items_filler.hide()
    items_button.show()
    
    data_panel.hide()
    data_filler.show()
    data_button.show()
    
    custom_panel.hide()
    custom_filler.show()
    custom_button.show()
    
    system_menu.hide()
    system_filler.show()
    system_button.show()


func data_panel_show():
    filler_panel.size_flags_stretch_ratio = 2
    filler_panel.show()
    h_box_container.size_flags_stretch_ratio = 1
    h_box_container.show()
    
    items_menu.hide()
    items_filler.hide()
    items_button.show()
    
    data_panel.show()
    data_filler.hide()
    data_button.show()
    
    custom_panel.hide()
    custom_filler.hide()
    custom_button.show()
    
    system_menu.hide()
    system_filler.hide()
    system_button.show()


func custom_panel_show():
    filler_panel.size_flags_stretch_ratio = 2
    filler_panel.show()
    h_box_container.size_flags_stretch_ratio = 1
    h_box_container.show()
    
    items_menu.hide()
    items_filler.hide()
    items_button.show()
    
    data_panel.hide()
    data_filler.hide()
    data_button.show()
    
    custom_panel.show()
    custom_filler.hide()
    custom_button.show()
    
    system_menu.hide()
    system_filler.hide()
    system_button.show()


func system_menu_show():
    filler_panel.size_flags_stretch_ratio = 3
    filler_panel.show()
    h_box_container.size_flags_stretch_ratio = 2
    h_box_container.show()
    
    items_menu.hide()
    items_filler.show()
    items_button.show()
    
    data_panel.hide()
    data_filler.show()
    data_button.show()
    
    custom_panel.hide()
    custom_filler.show()
    custom_button.show()
    
    system_menu.show()
    system_filler.hide()
    system_button.show()
