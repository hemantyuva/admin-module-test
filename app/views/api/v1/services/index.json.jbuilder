json.code 200
json.message "Service list fetch successfully"
json.services @services, partial: 'api/v1/services/service', as: :service