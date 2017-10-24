class ImportContact
  include ActiveModel::Model
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations
  attr_accessor :file
  def accessible_attributes
   ["id" , "first_name" , "last_name" , "email" , "phone_number" , "mobile_number" , "skype" , "notes"]
  end


  def initialize(attributes = {})
    attributes.each { |name, value| send("#{name}=", value) }
  end

  def persisted?
    false
  end

  def save
    if imported_contacts.map(&:valid?).all?
      imported_contacts.each(&:save!)
      true
    else
      imported_contacts.each_with_index do |contact, index|
        contact.errors.full_messages.each do |message|
          errors.add :base, "Row #{index+2}: #{message}"
        end
      end
      false
    end
  end

  def imported_contacts
    @imported_contacts ||= load_imported_contacts
  end

  def load_imported_contacts
    spreadsheet = Roo::Spreadsheet.open(file.path)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).map do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]    
      contact = Contact.find_by(id: row["id"]) || Contact.new 
      contact.attributes = row.to_hash.slice(*accessible_attributes)     
      contact
    end    
  end
end




 