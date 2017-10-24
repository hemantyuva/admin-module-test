json.code 200
json.message "Exam fetched successfully"
json.exams @exam, partial: 'api/v1/exams/exam', as: :exam