class ImportSubject
  include ActiveModel::Model
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations
  attr_accessor :file
  def accessible_attributes
    ["name" , "description" , "Subject_ID" , "school_id"]
  end


  def initialize(attributes = {})    
    attributes.each { |name, value| send("#{name}=", value) }
  end

  def persisted?
    false
  end

  def save
    if imported_subjects.map(&:valid?).all?
      imported_subjects.each(&:save!)
      true
    else
      imported_subjects.each_with_index do |subject, index|
        subject.errors.full_messages.each do |message|
          errors.add :base, "Row #{index+2}: #{message}"
        end
      end
      false
    end
  end

  def imported_subjects
    @imported_subjects ||= load_imported_subjects
  end

  def load_imported_subjects
    spreadsheet = Roo::Spreadsheet.open(file.path)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).map do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]    
      subject = Subject.find_by(id: row["id"]) || Subject.new
      subject.attributes = row.to_hash.slice(*accessible_attributes)     
      subject
    end    
  end
end




 