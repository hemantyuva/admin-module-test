json.id   event.id
json.title   event.title
json.start_date   event.start_date.present? ? event.start_date.strftime("%d/%m/%Y") : ""
json.end_date   event.end_date.present? ? event.end_date.strftime("%d/%m/%Y") : ""
json.start_time   event.start_time.present? ? event.start_time.strftime("%H/%M/%p") : ""
json.end_time   event.end_time.present? ? event.end_time.strftime("%H/%M/%p") : ""
json.location   event.location
json.event_type   event.event_type
json.reminder   event.reminder
json.description   event.description
json.created_at   event.created_at.strftime("%d/%m/%Y")
json.updated_at   event.updated_at.strftime("%d/%m/%Y")
json.notes   event.notes
json.group   event.group
json.school   event.school




