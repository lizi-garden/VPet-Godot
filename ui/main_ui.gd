extends Control

signal popup_items_window(tab_name :String)

@onready var items_menu = $PopupBar/Items
@onready var menu_button = $MenuButton


func _ready():
    items_menu.connect("index_pressed", _on_items_button_index_pressed)
    menu_button.get_popup().connect("index_pressed", _on_items_button_index_pressed)


func _on_items_button_index_pressed(index):
    var item_name = items_menu.get_item_text(index).to_lower()
    popup_items_window.emit(item_name)
