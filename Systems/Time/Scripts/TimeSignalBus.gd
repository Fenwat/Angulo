extends Node

# emitted
signal date_time_updated(date_time: DateTime, date_time_as_seconds: float)

# emitted when the day is over
signal day_finished(game_date: GameDate)

# emitted when the current day changes to a new day
signal date_changed(new_game_date: GameDate)

# emitted when date is first being set
signal initial_date_set(initial_game_date: GameDate, initial_month_name: String)

# emmitted when an 'event time' is reached (every 5 seconds)
signal event_time_reached(event_time: String)

# emitted when the month changes
signal new_month_reached(new_month_name: String)
