json.code 200
json.message "Merchant list fetched successfully"
json.merchants @merchants, partial: 'api/v1/merchants/merchant', as: :merchant