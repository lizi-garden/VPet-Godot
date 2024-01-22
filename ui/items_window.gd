extends Window


@onready var food_button = $HBoxContainer/VBoxContainer/Food
@onready var drink_button = $HBoxContainer/VBoxContainer/Drink
@onready var medicine_button = $HBoxContainer/VBoxContainer/Medicine
@onready var food_container = $HBoxContainer/FoodContainer
@onready var drink_container = $HBoxContainer/DrinkContainer
@onready var medicine_container = $HBoxContainer/MedicineContainer
@onready var food_item_list = $HBoxContainer/FoodContainer/ItemList
@onready var drink_item_list = $HBoxContainer/DrinkContainer/ItemList
@onready var medicine_item_list = $HBoxContainer/MedicineContainer/ItemList


func _init():
    pass


func _ready():
    connect("close_requested", hide)
    connect("focus_exited", hide)
    
    food_button.connect("toggled", func(toggled_on): if toggled_on: switch_tab("food"))
    drink_button.connect("toggled", func(toggled_on): if toggled_on: switch_tab("drink"))
    medicine_button.connect("toggled", func(toggled_on): if toggled_on: switch_tab("medicine"))
    
    food_item_list.connect("item_activated", func(index): _on_item_activated(index, "food"))
    drink_item_list.connect("item_activated", func(index): _on_item_activated(index, "drink"))
    medicine_item_list.connect("item_activated", func(index): _on_item_activated(index, "medicine"))
    pass


func switch_tab(tab :String):
    match tab:
        "food":
            food_container.show()
            drink_container.hide()
            medicine_container.hide()
        "drink":
            food_container.hide()
            drink_container.show()
            medicine_container.hide()
        "medicine":
            food_container.hide()
            drink_container.hide()
            medicine_container.show()


func _on_item_activated(index :int, category :String):
    var parent = get_parent()
    match category:
        "food":     parent.eat.emit(food_item_list.get_item_icon(index))
        "drink":    parent.drink.emit(drink_item_list.get_item_icon(index))
        "medicine": parent.eat.emit(medicine_item_list.get_item_icon(index))

    hide()
