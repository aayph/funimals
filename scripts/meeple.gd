extends Node
class_name Meeple

var happiness: float

func change_happiness(happiness_change: float) -> float:
	happiness += happiness_change
	happiness = clamp(happiness, -1.0, 1.0)
	return happiness
