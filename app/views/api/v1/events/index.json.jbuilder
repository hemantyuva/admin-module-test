json.code 200
json.message "Event list fetched successfully"
json.events @events, partial: 'api/v1/events/event', as: :event