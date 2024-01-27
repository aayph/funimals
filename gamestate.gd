extends Node
class_name State

var Money: float
var MoneyPerHappiness: float = 100.0

signal money_changed(money_added:float, total_money: float)
signal meeple_happiness_changed(meeple: Meeple, value: float, affect_money: bool)

func _ready() -> void:
	meeple_happiness_changed.connect(_on_meeple_happiness_changed)

func set_money(new_money: float):
	var old_money := Money
	Money = new_money
	money_changed.emit(Money - old_money, Money)

func add_money(add_value: float):
	Money += add_value
	money_changed.emit(add_value, Money)

func _on_meeple_happiness_changed(meeple: Meeple, value: float, affect_money: bool):
	if affect_money and value > 0.0:
		add_money(value * MoneyPerHappiness)
