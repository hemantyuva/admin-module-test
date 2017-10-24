class ImportInstitute
  include ActiveModel::Model
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations
  attr_accessor :file
  def accessible_attributes
   ["id","name","location","description","contact_number","email", "latitude", "longitude", "logo", "country", "state", "status", "contact_id"]
  end


  def initialize(attributes = {})    
    attributes.each { |name, value| send("#{name}=", value) }
  end

  def persisted?
    false
  end

  def save
    if imported_institutions.map(&:valid?).all?
      imported_institutions.each(&:save!)
      true
    else
      imported_institutions.each_with_index do |institution, index|
        institution.errors.full_messages.each do |message|
          errors.add :base, "Row #{index+2}: #{message}"
        end
      end
      false
    end
  end

  def imported_institutions
    @imported_institutions ||= load_imported_institutions
  end

  def load_imported_institutions
    spreadsheet = Roo::Spreadsheet.open(file.path)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).map do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]    
      institution = Institution.find_by(id: row["id"]) || Institution.new
      institution.attributes = row.to_hash.slice(*accessible_attributes)     
      institution
    end    
  end
end




 