extends Control

onready var health_bar = $healthBar;
onready var update_tween = $updateTween;

func Health_Update(hp: int, amount: int):
	health_bar.value = hp;
	update_tween.interpolate_property(health_bar, "value", health_bar.value, hp, 0.4, Tween.TRANS_SINE, Tween.EASE_IN_OUT);
	update_tween.start();

func MaxHealth_Update(MaxHealth: int):
	health_bar.max_value = MaxHealth;
