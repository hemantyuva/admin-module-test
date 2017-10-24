json.code 200
json.message "Contact fetched successfully"
json.contact @contact, partial: 'api/v1/contacts/contact', as: :contact