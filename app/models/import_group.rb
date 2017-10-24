class ImportGroup
  include ActiveModel::Model
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations
  attr_accessor :file
  def accessible_attributes
    ["Group_ID","description","school_id"]
  end


  def initialize(attributes = {})    
    attributes.each { |name, value| send("#{name}=", value) }
  end

  def persisted?
    false
  end

  def save
    if imported_groups.map(&:valid?).all?
      imported_groups.each(&:save!)
      true
    else
      imported_groups.each_with_index do |group, index|
        group.errors.full_messages.each do |message|
          errors.add :base, "Row #{index+2}: #{message}"
        end
      end
      false
    end
  end

  def imported_groups
    @imported_groups ||= load_imported_groups
  end

  def load_imported_groups
    spreadsheet = Roo::Spreadsheet.open(file.path)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).map do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]    
      group = Group.find_by(id: row["id"]) || Group.new
      group.attributes = row.to_hash.slice(*accessible_attributes)     
      group
    end    
  end
end




 