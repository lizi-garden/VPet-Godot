@tool
extends Control
class_name PopupBar

signal button_pressed(button_name :String)

var dock :HBoxContainer = HBoxContainer.new()

var viewport_size   :Vector2

func _ready():
    viewport_size = get_viewport_rect().size
    
    if dock is HBoxContainer: 
        dock.custom_minimum_size = Vector2(250, 50)
        dock.alignment = BoxContainer.ALIGNMENT_CENTER
        dock.tooltip_text = "double click to hide or show"
        dock.size = Vector2(viewport_size.x, viewport_size.y / 5)
        dock.position = Vector2(0, viewport_size.y * 4 / 5)
        add_child(dock)
    
    for child in get_children():
        if child is PopupMenu:
            var popup_button = Button.new()
            popup_button.text = child.name
            popup_button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
            popup_button.text_overrun_behavior = TextServer.OVERRUN_TRIM_ELLIPSIS
            popup_button.clip_text = true
            popup_button.connect("mouse_entered", func(): show_popup_menu(popup_button, child))
            popup_button.connect("focus_entered", func(): show_popup_menu(popup_button, child))
            dock.add_child(popup_button)
        
        if child is PopupPanel:
            var popup_button = Button.new()
            popup_button.text = child.name
            popup_button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
            popup_button.text_overrun_behavior = TextServer.OVERRUN_TRIM_ELLIPSIS
            popup_button.clip_text = true
            popup_button.connect("mouse_entered", func(): show_popup_panel(popup_button, child))
            popup_button.connect("focus_entered", func(): show_popup_panel(popup_button, child))
            dock.add_child(popup_button)


var window_pos      :Vector2

var button_rect     :Rect2
var popup_menu_rect :Rect2
func show_popup_menu(button :Button, popup_menu :PopupMenu):
    for child in get_children():
        if child is Popup:  child.hide()
    
    # Get Window Position
    window_pos = get_tree().get_root().position
    
    # Get Button Position
    button_rect.size = button.size
    button_rect.position = button.global_position + window_pos
    
    # Set PopMenu Size 
    popup_menu_rect.size = Vector2(button_rect.size.x, popup_menu.size.y)
    
    # Set Button Position
    popup_menu_rect.position.x = button_rect.position.x
    popup_menu_rect.position.y = button_rect.position.y - popup_menu_rect.size.y
    
    popup_menu.popup(popup_menu_rect)


var popup_panel_rect:Rect2
func show_popup_panel(_button :Button, popup_panel :PopupPanel):
    for child in get_children():
        if child is Popup:  child.hide()
    
    # Get Window Position
    window_pos = get_tree().get_root().position
    
    # Get Viewport Size
    viewport_size = get_viewport_rect().size
    
    # Set Poppanel Size
    popup_panel_rect.size = Vector2(viewport_size.x, viewport_size.y*2/5 - 5)
    
    # Set Button Position
    popup_panel_rect.position.x = window_pos.x
    popup_panel_rect.position.y = window_pos.y + viewport_size.y*2/5
    
    popup_panel.popup(popup_panel_rect)
