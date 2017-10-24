class ImportAssignment
  include ActiveModel::Model
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations
  attr_accessor :file
  def accessible_attributes
    ["user_id" ,"school_id" ,"group_id"]
  end


  def initialize(attributes = {})    
    attributes.each { |name, value| send("#{name}=", value) }
  end

  def persisted?
    false
  end

  def save
    if imported_assignments.map(&:valid?).all?
      imported_assignments.each(&:save!)
      true
    else
      imported_assignments.each_with_index do |assignment, index|
        assignment.errors.full_messages.each do |message|
          errors.add :base, "Row #{index+2}: #{message}"
        end
      end
      false
    end
  end

  def imported_assignments
    @imported_assignments ||= load_imported_assignments
  end

  def load_imported_assignments
    spreadsheet = Roo::Spreadsheet.open(file.path)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).map do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]    
      assignment = Assignment.find_by(id: row["id"]) || Assignment.new
      assignment.attributes = row.to_hash.slice(*accessible_attributes)     
      assignment
    end    
  end
end




 