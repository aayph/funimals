extends Node
class_name State

var Money: float

signal money_changed(money_added, total_money)

func set_money(new_money: float):
	var old_money := Money
	Money = new_money
	money_changed.emit(Money - old_money, Money)

func add_money(add_value: float):
	Money += add_value
	money_changed.emit(add_value, Money)
