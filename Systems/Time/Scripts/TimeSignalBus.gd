extends Node

# emitted
signal date_time_updated(date_time: DateTime, date_time_as_seconds: float)

# emitted when the day is over
signal day_finished(game_date: GameDate)

# emitted when the current day changes to a new day
signal date_changed(new_game_date: GameDate, days_moved: int)
