json.code 200
json.message "Subject list successfully"
json.subjects @subjects, partial: 'api/v1/subjects/subject', as: :subject