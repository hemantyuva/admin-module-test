json.code 200
json.message "Schedule fetched successfully"
json.schedules @schedules, partial: 'api/v1/schedules/schedule', as: :schedule