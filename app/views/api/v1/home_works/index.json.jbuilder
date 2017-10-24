json.code 200
json.message "Home Work list fetched successfully"
json.home_works @home_works, partial: 'api/v1/home_works/home_work', as: :home_work