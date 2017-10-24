json.id home_work.id
json.deadline_date   home_work.deadline_date.present? ? home_work.deadline_date.strftime("%d/%m/%Y") : ""
json.deadline_time   home_work.deadline_time
json.description home_work.description
json.subject_id home_work.subject_id
json.title home_work.title
json.school home_work.school
json.group home_work.group


