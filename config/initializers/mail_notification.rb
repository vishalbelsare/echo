ActivityTrackingNotification.user_split_condition = {}#{:conditions => ["(id % 7) = ?", week_day]}
ActivityTrackingNotification.tracking_period = 10.minutes.ago #7.days.ago
ActivityTrackingNotification.delivery_period = Time.10.minutes.from_now #6.hours.from_now #Time.now.tomorrow.midnight