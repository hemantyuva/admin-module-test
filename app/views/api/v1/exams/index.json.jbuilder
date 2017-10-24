json.code 200
json.message "Exam list successfully"
json.exams @exams, partial: 'api/v1/exams/exam', as: :exam