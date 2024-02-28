extends Resource
class_name UserData

## base
################################################################################

@export var name :String = ""
@export var time :String = ""
@export var mood :AnimeData.MOOD_NAME


## level
################################################################################

signal level_value_changed(value :int)
signal level_max_value_changed(value :int)

@export var level_value :int = 1 : set = _set_level_value
@export var level_max_value :int = 100 : set = _set_level_max_value

func _set_level_value(value :int):
    if value > level_max_value:
        exp_max_value = 1_890_000
    else:
        exp_max_value = value^3 + 88 * value^2 + 99 * value + 100

    level_value = value
    level_value_changed.emit(value)


func _set_level_max_value(value :int):
    level_max_value = value
    level_max_value_changed.emit(value)


## exp
################################################################################

signal exp_value_changed(value :int)
signal exp_max_value_changed(value :int)

@export var exp_value :int = 0 : set = _set_exp_value
@export var exp_max_value :int = 288 : set = _set_exp_max_value

func _set_exp_value(value :int):
    if value > exp_max_value:
        exp_value = value - exp_max_value
        level_value += 1
    else:
        exp_value = value

    exp_value_changed.emit(value)


func _set_exp_max_value(value :int):
    exp_max_value = value
    exp_max_value_changed.emit(value)


## money
################################################################################

signal money_value_changed(value :int)

@export var money_value :int = 1000 : set = _set_money_value

func _set_money_value(value):
    money_value = value
    money_value_changed.emit(value)


## health
################################################################################

signal health_value_changed(value :int)
signal health_max_value_changed(value :int)

@export var health_value :int = 2000 : set = _set_health_value
@export var health_max_value :int = 2000 : set = _set_health_max_value

func _set_health_value(value):
    if value > health_max_value:
        exp_value += 0.5 * (value - health_max_value)
        health_value = health_max_value
    else:
        health_value = value
    
    health_value_changed.emit(value)


func _set_health_max_value(value):
    health_max_value = value
    health_max_value_changed.emit(value)


## hunger
################################################################################

signal hunger_value_changed(value :int)
signal hunger_max_value_changed(value :int)

@export var hunger_value :int = 2000 : set = _set_hunger_value
@export var hunger_max_value :int = 2000 : set = _set_hunger_max_value

func _set_hunger_value(value):
    if value > hunger_max_value:
        exp_value += 0.5 * (value - hunger_max_value)
        hunger_value = hunger_max_value
    else:
        hunger_value = value
    
    hunger_value_changed.emit(value)


func _set_hunger_max_value(value):
    hunger_max_value = value
    hunger_max_value_changed.emit(value)


## thirst
################################################################################

signal thirst_value_changed(value :int)
signal thirst_max_value_changed(value :int)

@export var thirst_value :int = 2000 : set = _set_thirst_value
@export var thirst_max_value :int = 2000 : set = _set_thirst_max_value

func _set_thirst_value(value):
    if value > thirst_max_value:
        exp_value += 0.5 * (value - thirst_max_value)
        thirst_value = thirst_max_value
    else:
        thirst_value = value
    
    thirst_value_changed.emit(value)


func _set_thirst_max_value(value):
    thirst_max_value = value
    thirst_max_value_changed.emit(value)


## mood
################################################################################

signal mood_value_changed(value :int)
signal mood_max_value_changed(value :int)

@export var mood_value :int = 2000 : set = _set_mood_value
@export var mood_max_value :int = 2000 : set = _set_mood_max_value

func _set_mood_value(value):
    if value > mood_max_value:
        exp_value += 0.5 * (value - mood_max_value)
        mood_value = mood_max_value
    else:
        mood_value = value
    
    mood_value_changed.emit(value)


func _set_mood_max_value(value):
    mood_max_value = value
    mood_max_value_changed.emit(value)
    

## idle
################################################################################

func update_idle_value():
    hunger_value -= 10
    if hunger_value < 0.5 * hunger_max_value:
        pass
    
    thirst_value -= 10
    if thirst_value < 0.5 * thirst_max_value:
        pass


## work
################################################################################

func update_work_value():
    var n :float = 1.0
    var m :float = 1.0
    match mood:
        "happy":
            n = 0.5
            m = 1.5
        "default":
            n = 1.0
            m = 1.5
        "poorcondition":
            n = 1.5
            m = 0.5
        "ill":              return
        _:                  return
    
    hunger_value -= int(50 * n)
    thirst_value -= int(50 * n)
    mood_value -= int(50 * n)
    money_value += int(100 * sqrt(level_value) * m)


## study
################################################################################

func update_study_value():
    var n :float = 1.0
    var m :float = 1.0
    match mood:
        "happy":
            n = 0.5
            m = 1.5
        "default":
            n = 1.0
            m = 1.5
        "poorcondition":
            n = 1.5
            m = 0.5
        "ill":              return
        _:                  return
    
    hunger_value -= int(20 * n)
    thirst_value -= int(20 * n)
    mood_value += int(20 * n)
    exp_value += int(500 * m)

