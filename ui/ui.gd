extends CanvasLayer

@onready var timer = $Timer
@onready var dock = $Dock
@onready var animation_player = $AnimationPlayer
@onready var info_panel = $InfoPanel
@onready var eat_button = $Dock/EatButton

var viewport_size   :Vector2
var eat_popup       :PopupMenu

func _ready():
    viewport_size = get_viewport().size
    dock.set_deferred("size", Vector2(float(viewport_size.x), float(viewport_size.y)/5))
    dock.set_deferred("position", Vector2(0, float(viewport_size.y)*4/5))
    dock.set_deferred("modulate:a", 0)
    
    timer.connect("timeout", func(): animation_player.play("fade_out"))
    pass

