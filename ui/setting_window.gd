extends Window


func _enter_tree():
    show()


func _exit_tree():
    queue_free()


func _ready():
    connect("close_requested", save_dialog.show)
    connect("focus_exited", save_dialog.show)
    
    data_init()
    data_frozen_init()
    modifier_engine_init()
    allow_moving_init()
    save_dialog_init()


@onready var tab_container = $TabContainer

func switch_tab(tab :String):
    match tab:
        "data":     tab_container.current_tab = 0
        "custom":   tab_container.current_tab = 1
        "Mods":     tab_container.current_tab = 2
        "system":   tab_container.current_tab = 3
        "info":     tab_container.current_tab = 4


## Data

@onready var data_label = $TabContainer/Data/VBoxContainer/Data/Label
@onready var load_data_option_button = $TabContainer/Data/VBoxContainer/Data/OptionButton
@onready var save_data_line_edit = $TabContainer/Data/VBoxContainer/Data/LineEdit
@onready var load_data_button = $TabContainer/Data/VBoxContainer/Data/LoadButton
@onready var save_data_button = $TabContainer/Data/VBoxContainer/Data/SaveButton
@onready var delete_data_button = $TabContainer/Data/VBoxContainer/Data/DeleteButton
@onready var cancel_data_button = $TabContainer/Data/VBoxContainer/Data/CancelButton


var num = 1

func data_init():
    load_data_option_button.connect("item_selected", load_data)
    load_data_button.connect("pressed", load_data)
    save_data_button.connect("pressed", save_data)
    delete_data_button.connect("pressed", delete_data)
    cancel_data_button.connect("pressed", cancel_data)
    

func load_data(index :int = load_data_option_button.selected):
    if index:
        pass
    else:
        data_label.text = tr("Save Data")
        load_data_option_button.hide()
        load_data_option_button.selected = -1
        save_data_line_edit.show()
        save_data_line_edit.text = ""
        load_data_button.hide()
        save_data_button.show()
        delete_data_button.hide()
        cancel_data_button.show()


func save_data(text :String = save_data_line_edit.text):
    var new_str
    if text == "":
        new_str = "New Data " + str(num)
        num += 1
    else:
        new_str = text

    load_data_option_button.add_item(new_str)


func delete_data(index :int = load_data_option_button.selected):
    if index < 1:
        pass


func cancel_data():
    data_label.text = tr("Load Data")
    load_data_option_button.show()
    load_data_option_button.selected = -1
    save_data_line_edit.hide()
    save_data_line_edit.text = ""
    load_data_button.show()
    save_data_button.hide()
    delete_data_button.show()
    cancel_data_button.hide()


## Data-Frozen

@onready var data_frozen_check_button = $TabContainer/Data/VBoxContainer/DataFrozen/CheckButton
@onready var state_frozen_option_button = $TabContainer/Data/VBoxContainer/DataFrozen/OptionButton

@export var data_frozen = false
@export var state_frozen :String

func data_frozen_init():
    data_frozen_check_button.connect("toggled", _on_data_frozen_check_button)
    state_frozen_option_button.connect("item_selected", _on_state_frozen_option_button)
    state_frozen_option_button.disabled = !data_frozen
    state_frozen_option_button.selected = -1


func _on_data_frozen_check_button(toggled_on):
    data_frozen = toggled_on
    state_frozen_option_button.disabled = !data_frozen
    state_frozen_option_button.selected = -1


func _on_state_frozen_option_button(index):
    state_frozen = state_frozen_option_button.get_item_text(index)


## Restore Default


## ModifierEngine

@onready var modifier_check_box = $TabContainer/Data/VBoxContainer/ModifierCheckBox
@onready var level_button = $TabContainer/Data/VBoxContainer/ModifierContainer/LevelButton
@onready var money_button = $TabContainer/Data/VBoxContainer/ModifierContainer/MoneyButton
@onready var health_button = $TabContainer/Data/VBoxContainer/ModifierContainer/HealthButton
@onready var hunger_button = $TabContainer/Data/VBoxContainer/ModifierContainer/HungerButton
@onready var thirsty_button = $TabContainer/Data/VBoxContainer/ModifierContainer/ThirstyButton

var ui :Node

func modifier_engine_init():
    ui = get_parent()
    level_button.connect("pressed", func(): ui.level_value += 1)
    money_button.connect("pressed", func(): ui.money_value += 100_000)
    health_button.connect("pressed", func(): ui.health_value = 500)
    hunger_button.connect("pressed", func(): ui.hunger_value = 500)
    thirsty_button.connect("pressed", func(): ui.thirsty_value = 500)
    modifier_check_box.connect("toggled", _on_modifier_check_box)
    _on_modifier_check_box(modifier_check_box.button_pressed)


func _on_modifier_check_box(toggled_on):
    level_button.disabled = !toggled_on
    money_button.disabled = !toggled_on
    health_button.disabled = !toggled_on
    hunger_button.disabled = !toggled_on
    thirsty_button.disabled = !toggled_on


## Arrow Moving

@onready var allow_moving_check_button = $TabContainer/Custom/VBoxContainer/AllowMoving/CheckButton

@export var allow_moving = false

func allow_moving_init():
    allow_moving_check_button.connect("toggled", func(toggle_on): allow_moving = toggle_on)
    

## Raised Delay

## Idle Delay

## Moving Delay

## Save Dialog

@onready var save_dialog = $SaveDialog

func save_dialog_init():
    save_dialog.connect("canceled", queue_free)
    save_dialog.connect("confirmed", save_profile)


func save_profile():
    var config = ConfigFile.new()
    
    config.set_value("data", "load data", load_data_option_button.text)
    config.set_value("data", "data frozen", data_frozen_check_button.button_pressed)
    
    config.save("user://setting.cfg")
    
    queue_free()
