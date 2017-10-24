class ImportUser
  include ActiveModel::Model
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations
  attr_accessor :file
  def accessible_attributes
    ["email","first_name","last_name","password","school_id","student_number","gender","picture","school_Grade","degree","father_name","father_email","mother_name","mother_email","Status"]
  end


  def initialize(attributes = {})    
    attributes.each { |name, value| send("#{name}=", value) }
  end

  def persisted?
    false
  end

  def save
    if imported_users.map(&:valid?).all?
      imported_users.each(&:save!)
      true
    else
      imported_users.each_with_index do |user, index|
        user.errors.full_messages.each do |message|
          errors.add :base, "Row #{index+2}: #{message}"
        end
      end
      false
    end
  end

  def imported_users
    @imported_users ||= load_imported_users
  end

  def load_imported_users
    spreadsheet = Roo::Spreadsheet.open(file.path)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).map do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]    
      user = User.find_by(id: row["id"]) || User.new
      user.attributes = row.to_hash.slice(*accessible_attributes)     
      user
    end
  end
end




 