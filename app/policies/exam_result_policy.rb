class ExamResultPolicy < ApplicationPolicy
   def index?
    is_valid_user?
  end

  def new
  end
 
  def create?
    is_valid_user?
  end
  def edit
  end
 
  def update?
    is_valid_user?
  end
 
  def destroy?
    is_valid_user?
  end
 
  private
 
    def article
      record
    end

    def is_valid_user?
      (user.role.present?) and (user.role.name == "Administrator" || user.role.name == "School manager" || user.role.name == "School Assistant" )
    end
end
