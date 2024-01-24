extends Window


func _enter_tree():
    show()


func _exit_tree():
    queue_free()


func _ready():
    connect("close_requested", hide)
    connect("focus_exited", hide)
    
    data_init()
    data_frozen_init()
    modifier_engine_init()
    allow_moving_init()


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

@onready var modifier_check_box = $TabContainer/Data/VBoxContainer/ModifierEngine/CheckBox
@onready var modifier_button = $TabContainer/Data/VBoxContainer/ModifierEngine/Button
@onready var health_modifier_check_box = $TabContainer/Data/VBoxContainer/HealthModifier/CheckBox
@onready var health_modifier_h_slider = $TabContainer/Data/VBoxContainer/HealthModifier/HSlider
@onready var health_modifier_spin_box = $TabContainer/Data/VBoxContainer/HealthModifier/SpinBox


func modifier_engine_init():
    modifier_check_box.connect("toggled", _on_modifier_check_box)
    modifier_button.disabled = !modifier_check_box.button_pressed
    health_modifier_check_box.disabled = !modifier_check_box.button_pressed
    health_modifier_h_slider.editable = false
    health_modifier_spin_box.editable = false
    
    health_modifier_check_box.connect("toggled", _on_health_modifier_check_box)


func _on_modifier_check_box(toggled_on):
    modifier_button.disabled = !toggled_on
    health_modifier_check_box.disabled = !toggled_on
    
    if toggled_on == false:
        health_modifier_check_box.button_pressed = false


func _on_health_modifier_check_box(toggled_on):
    health_modifier_h_slider.editable = toggled_on
    health_modifier_spin_box.editable = toggled_on


## Arrow Moving

@onready var allow_moving_check_button = $TabContainer/Custom/VBoxContainer/AllowMoving/CheckButton

@export var allow_moving = false

func allow_moving_init():
    allow_moving_check_button.connect("toggled", func(toggle_on): allow_moving = toggle_on)
    

## Raised Delay

## Idle Delay

## Moving Delay
