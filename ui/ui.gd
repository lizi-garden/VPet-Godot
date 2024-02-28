extends CanvasLayer

signal exit
signal eat(food :Texture2D)
signal drink(drink :Texture2D)
signal screenshot
signal recording(start :bool)


@onready var right_click_menu = $RightClickMenu
@onready var main_ui = $MainUI
@onready var screenshot_dialog = $ScreenShotDialog


var setting_window = preload("res://ui/setting_window.tscn").instantiate()
var items_window = preload("res://ui/items_window.tscn").instantiate()

var viewport_pos    :Vector2
var viewport_size   :Vector2


func _ready():
    autoload_userdata()
    main_ui.connect("custom_button_pressed", func(): _on_show_setting_window("custom"))
    main_ui.connect("data_button_pressed", func(): _on_show_setting_window("data"))
    
    viewport_size = get_viewport().size
    right_click_menu.hide()


var userdata :UserData

func autoload_userdata():
    var path = "user://save/autosave.tres"
    var load_res = ResourceLoader.exists(path)
    
    if load_res:
        userdata = ResourceLoader.load(path)
    else:
        userdata = UserData.new()
        userdata.name = "Auto Save"
        userdata.time = Time.get_date_string_from_system()
        userdata.mood = AnimeData.MOOD_NAME.HAPPY
        
        DirAccess.make_dir_absolute("user://save")
        var save_res = ResourceSaver.save(userdata, path)
        assert(save_res == OK)
        
    main_ui.update_data(userdata)


func autosave_userdata():
    var path = "user://save/autosave.tres"
    DirAccess.make_dir_absolute("user://save")
    
    var res = ResourceSaver.save(userdata, path)
    assert(res == OK)
    

func load_userdata(dataname :String):
    var path = "user://save/" + dataname.to_lower().replace(" ", "_")
    var res = ResourceLoader.exists(path)
    
    if res:
        userdata = ResourceLoader.load(path)
        main_ui.update_data(userdata)
    

func _unhandled_input(event):
    if event is InputEventMouseButton:
        if event.button_index == MOUSE_BUTTON_LEFT and event.double_click:
            main_ui.visible = !main_ui.visible
        
        if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
            viewport_pos = get_tree().get_root().position
            right_click_menu.position = viewport_pos + event.global_position
            right_click_menu.show()

               
func _on_right_click_menu_index_pressed(index :int):
    match right_click_menu.get_item_text(index).to_lower():
        "setting":  _on_show_setting_window()
        "dock":     main_ui.visible = !main_ui.visible
        "exit":     exit.emit()


func _on_system_button_pressed(tab_name):
    match tab_name:
        "system":
            _on_show_setting_window("system")
        "screenshot":
            screenshot.emit()
            screenshot_dialog.show()
        "recording":
            pass


func _on_show_setting_window(tab_name :String = "data"):
    if not has_node("SettingWindow"):
        add_child(setting_window)
    
    setting_window.switch_tab(tab_name)
    setting_window.show()


func _on_show_items_window(tab_name :String = "food"):
    if not has_node("ItemsWindow"):
        add_child(items_window)
    
    items_window.switch_tab(tab_name)
    items_window.show()

