extends CanvasLayer

@onready var right_click_menu = $RightClickMenu

var viewport_pos    :Vector2
var viewport_size   :Vector2

func _ready():
    viewport_size = get_viewport().size
    right_click_menu.hide()
    pass


func _unhandled_input(event):
    if event is InputEventMouseButton:
        if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
            viewport_pos = get_tree().get_root().position
            right_click_menu.position = viewport_pos + event.global_position
            right_click_menu.show()


