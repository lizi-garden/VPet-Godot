extends CanvasLayer

@onready var timer = $Timer
@onready var dock = $Dock
@onready var animation_player = $AnimationPlayer
@onready var right_click_menu = $RightClickMenu

var viewport_pos    :Vector2
var viewport_size   :Vector2

func _ready():
    viewport_size = get_viewport().size
    dock.set_deferred("size", Vector2(float(viewport_size.x), float(viewport_size.y)/5))
    dock.set_deferred("position", Vector2(0, float(viewport_size.y)*4/5))
    dock.set_deferred("modulate:a", 0)
    
    timer.connect("timeout", func(): animation_player.play("fade_out"))
    
    right_click_menu.hide()
    pass

func _unhandled_input(event):
    if event is InputEventMouseButton:
        if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
            viewport_pos = get_tree().get_root().position
            right_click_menu.position = viewport_pos + event.global_position
            right_click_menu.show()



