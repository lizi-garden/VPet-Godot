extends CanvasLayer

signal popup_items_window(tab_name :String)

@onready var items_menu = $PopupBar/Items
@onready var system_menu = $PopupBar/System
@onready var right_click_menu = $RightClickMenu

@export var wealth_value    :float
@export var health          :int
@export var mood            :int
@export var satiety         :int
@export var thirst          :int

var viewport_pos    :Vector2
var viewport_size   :Vector2

func _ready():
    viewport_size = get_viewport().size
    right_click_menu.hide()


func _unhandled_input(event):
    if event is InputEventMouseButton:
        if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
            viewport_pos = get_tree().get_root().position
            right_click_menu.position = viewport_pos + event.global_position
            right_click_menu.show()


func _on_item_index_pressed(index):
    var item_name = items_menu.get_item_text(index).to_lower()
    popup_items_window.emit(item_name)
