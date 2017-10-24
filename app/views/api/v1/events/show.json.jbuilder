json.code 200
json.message "Event detail fetched successfully"
json.events @event, partial: 'api/v1/events/event', as: :event