json.code 200
json.message "signed in successfully"
json.user @user, partial: 'api/v1/users/user', as: :user