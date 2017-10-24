class ImportSchool
  include ActiveModel::Model
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations
  attr_accessor :file
  def accessible_attributes
    ["id","name","location","description","latitude","longitude","institution_id","logo","status","contact_id"]
  end


  def initialize(attributes = {})    
    attributes.each { |name, value| send("#{name}=", value) }
  end

  def persisted?
    false
  end

  def save
    if imported_schools.map(&:valid?).all?
      imported_schools.each(&:save!)
      true
    else
      imported_schools.each_with_index do |school, index|
        school.errors.full_messages.each do |message|
          errors.add :base, "Row #{index+2}: #{message}"
        end
      end
      false
    end
  end

  def imported_schools
    @imported_schools ||= load_imported_schools
  end

  def load_imported_schools
    spreadsheet = Roo::Spreadsheet.open(file.path)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).map do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]    
      school = School.find_by(id: row["id"]) || School.new
      school.attributes = row.to_hash.slice(*accessible_attributes)     
      school
    end    
  end
end




 