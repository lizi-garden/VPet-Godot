extends Window

@export var pin_window = false

@onready var food_button = $HBoxContainer/VBoxContainer/Food
@onready var drink_button = $HBoxContainer/VBoxContainer/Drink
@onready var medicine_button = $HBoxContainer/VBoxContainer/Medicine
@onready var gift_button = $HBoxContainer/VBoxContainer/Gift
@onready var food_container = $HBoxContainer/FoodContainer
@onready var drink_container = $HBoxContainer/DrinkContainer
@onready var medicine_container = $HBoxContainer/MedicineContainer
@onready var gift_container = $HBoxContainer/GiftContainer
@onready var food_item_list = $HBoxContainer/FoodContainer/ItemList
@onready var drink_item_list = $HBoxContainer/DrinkContainer/ItemList
@onready var medicine_item_list = $HBoxContainer/MedicineContainer/ItemList
@onready var gift_item_list = $HBoxContainer/GiftContainer/ItemList
@onready var pin_button = $PinButton


func _enter_tree():
    show()


func _exit_tree():
    queue_free()


func _init():
    pass


func _ready():
    connect("close_requested", queue_free)
    connect("focus_exited", queue_free)
    
    food_button.connect("toggled", func(toggled_on): if toggled_on: switch_tab("food"))
    drink_button.connect("toggled", func(toggled_on): if toggled_on: switch_tab("drink"))
    medicine_button.connect("toggled", func(toggled_on): if toggled_on: switch_tab("medicine"))
    gift_button.connect("toggled", func(toggled_on): if toggled_on: switch_tab("gift"))
    
    food_item_list.connect("item_activated", func(index): _on_item_activated(index, "food"))
    drink_item_list.connect("item_activated", func(index): _on_item_activated(index, "drink"))
    medicine_item_list.connect("item_activated", func(index): _on_item_activated(index, "medicine"))
    gift_item_list.connect("item_activated", func(index): _on_item_activated(index, "gift"))
    
    pin_button.connect("toggled", func(toggled_on): pin_window = toggled_on)

func switch_tab(tab :String):
    match tab:
        "food":
            food_container.show()
            drink_container.hide()
            medicine_container.hide()
            gift_container.hide()
        "drink":
            food_container.hide()
            drink_container.show()
            medicine_container.hide()
            gift_container.hide()
        "medicine":
            food_container.hide()
            drink_container.hide()
            medicine_container.show()
            gift_container.hide()
        "gift":
            food_container.hide()
            drink_container.hide()
            medicine_container.hide()
            gift_container.show()


func _on_item_activated(index :int, category :String):
    var ui = get_parent()
    match category:
        "food":     ui.eat.emit(food_item_list.get_item_icon(index))
        "drink":    ui.drink.emit(drink_item_list.get_item_icon(index))
        "medicine": ui.eat.emit(medicine_item_list.get_item_icon(index))
        "gift":     ui.gift.emit(gift_item_list.get_item_icon(index))

    if pin_window == false:
        queue_free()
