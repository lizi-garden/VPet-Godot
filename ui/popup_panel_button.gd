class_name PopupPanelButton
extends Button

signal about_to_popup

func _ready():
    popup_panel.hide()
    connect("mouse_entered", func(): show_popup_panel())
    pass


@export_category("PopupPanel")
@export var popup_panel :PopupPanel
@export var direct = false
@export var switch_on_hover = false
var window_pos      :Vector2
var viewport_size   :Vector2
var popup_panel_size:Vector2
var popup_panel_pos :Vector2
var button_size     :Vector2
var button_pos      :Vector2

## Adjusts popup position and sizing for the [b]panelButton[/b], then shows the [Popuppanel].
func show_popup_panel():
    # Get Window Position
    window_pos = get_tree().get_root().position
    
    # Get Viewport Size
    viewport_size = get_viewport_rect().size
    
    # Get Button Position
    button_size = size
    button_pos = global_position + window_pos
    
    # Set Poppanel Size
    popup_panel.size = Vector2(viewport_size.x, viewport_size.y*2/5 - 5)
    
    # Set Button Position
    popup_panel_pos.x = window_pos.x
    if direct:      popup_panel_pos.y = window_pos.y + viewport_size.y*2/5
    else:           popup_panel_pos.y = button_pos.y + button_size.y + 5
    popup_panel.position = popup_panel_pos
    
    popup_panel.show()
    about_to_popup.emit()
    pass


func hide_popup_panel():
    popup_panel.hide()
    pass
