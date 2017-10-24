json.code 200
json.message "Group list successfully"
json.groups @groups, partial: 'api/v1/groups/group', as: :group