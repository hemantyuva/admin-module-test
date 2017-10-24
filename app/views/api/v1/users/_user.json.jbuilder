json.id user.id
json.email user.email
json.first_name user.first_name
json.last_name user.last_name

json.student_number user.student_number
json.gender user.gender
json.school_Grade user.school_Grade
json.degree user.degree
json.picture user.reload.picture.try(:url)

json.father_name user.father_name
json.father_email user.father_email
json.mother_name user.mother_name
json.Status user.Status
json.authentication_token user.authentication_token
json.school user.school