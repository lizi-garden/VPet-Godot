class_name PopupMenuButton
extends Button

signal about_to_popup

func _ready():
    popup_menu.hide()
    connect("mouse_entered", func(): show_popup_menu())
    pass


@export_category("PopupMenu")
@export var popup_menu      :PopupMenu
@export var direct = false
@export var switch_on_hover = false
var window_pos      :Vector2
var popup_menu_size :Vector2
var popup_menu_pos  :Vector2
var button_size     :Vector2
var button_pos      :Vector2

## Adjusts popup position and sizing for the [b]MenuButton[/b], then shows the [PopupMenu].
func show_popup_menu():
    # Get Window Position
    window_pos = get_tree().get_root().position
    
    # Get Button Position
    button_size = size
    button_pos = global_position + window_pos
    
    # Set PopMenu Size 
    popup_menu.size = Vector2(button_size.x, popup_menu.size.y)
    popup_menu_size = popup_menu.size
    
    # Set Button Position
    popup_menu_pos.x = button_pos.x
    if direct:      popup_menu_pos.y = button_pos.y - popup_menu_size.y
    else:           popup_menu_pos.y = button_pos.y + button_size.y
    popup_menu.position = popup_menu_pos
    
    popup_menu.show()
    about_to_popup.emit()
    pass


func hide_popup_menu():
    popup_menu.hide()
    pass
