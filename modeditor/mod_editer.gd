extends Window

func _init():
    var screen_size = DisplayServer.screen_get_size()
    size = screen_size / 2
    pass


@onready var load_default_folder_dialog = $LoadDefaultFolderDialog
@onready var load_default_folder_line_edit = $VBoxContainer/LoadDefaultFolder/HBoxContainer/LineEdit
@onready var load_default_folder_button = $VBoxContainer/LoadDefaultFolder/HBoxContainer/Button
@onready var open_folder_dialog = $OpenFolderDialog
@onready var open_folder_line_edit = $VBoxContainer/OpenFolder/HBoxContainer/LineEdit
@onready var open_folder_button = $VBoxContainer/OpenFolder/HBoxContainer/Button
@onready var open_zip_dialog = $OpenZipDialog
@onready var open_zip_line_edit = $VBoxContainer/OpenZip/HBoxContainer/LineEdit
@onready var open_zip_button = $VBoxContainer/OpenZip/HBoxContainer/Button

var load_default_folder = "user://mod":
    set(value):
        load_default_folder_line_edit.text = value
        pass

var open_folder:
    set(value):
        open_folder_line_edit.text = value
        pass

var open_zip:
    set(value):
        open_zip_line_edit.text = value
        pass

func _ready():
    connect("close_requested", func(): get_tree().quit())
    
    load_default_folder_line_edit.text = ProjectSettings.globalize_path(load_default_folder)
    load_default_folder_button.connect("pressed", func(): load_default_folder_dialog.show())
    load_default_folder_dialog.connect("dir_selected", func(dir): load_default_folder = dir)
    open_folder_button.connect("pressed", func(): open_folder_dialog.show())
    open_folder_dialog.connect("dir_selected", func(dir): open_folder = dir)
    open_zip_button.connect("pressed", func(): open_zip_dialog.show())
    open_zip_dialog.connect("file_selected", func(path): open_zip = path)
    pass


func _on_file_index_pressed(index):
    match index:
        0: open_folder_dialog.show()
        1: open_zip_dialog.show()
    pass


var pet_animation           :Array[SpriteFrames]
var happy_startup_1         :Array[Texture2D]
var happy_startup_2         :Array[Texture2D]
var ill_startup             :Array[Texture2D]
var nomal_startup           :Array[Texture2D]
var poorcondition_startup   :Array[Texture2D]
var happy_default_1         :Array[Texture2D]
var happy_default_2         :Array[Texture2D]
var happy_default_3         :Array[Texture2D]
var ill_default_1           :Array[Texture2D]
var ill_default_2           :Array[Texture2D]
var normal_default_1        :Array[Texture2D]
var normal_default_2        :Array[Texture2D]
var normal_default_3        :Array[Texture2D]
var poorcondition_default_1 :Array[Texture2D]
var poorcondition_default_2 :Array[Texture2D]


func dir_contents(path):
    var dir = DirAccess.open(path)
    if dir:
        dir.list_dir_begin()
        var file_name = dir.get_next()
        while file_name != "":
            if dir.current_is_dir():
                print("发现目录：" + file_name)
            else:
                print("发现文件：" + file_name)
            file_name = dir.get_next()
    else:
        print("尝试访问路径时出错。")
    pass


func load_resource_from_path(path):
    # Get Mod name
    var modname = path.get_slice("/", -1)
    var savedir = load_default_folder + "/" + modname
    
    # Get Dir
    var dir = DirAccess.open(path)
    dir.include_hidden = false
    dir.include_navigational = false
    
    # Copy Files
    if dir.copy(path, savedir):
        print("copy successful")
        dir.change_dir(savedir)
    else:
        print("copy failed")
        return
    
    # Load File
    match path:
        var value when path.contains("startup"):
            pass
    pass


func load_resource_from_zip(file):
    pass
