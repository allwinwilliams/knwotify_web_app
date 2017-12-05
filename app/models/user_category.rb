class UserCategory < ApplicationRecord
  belongs_to :user, class_name: "User"
  belongs_to :category, class_name: "Category"
  validates :user_id, presence: true
  validates :category_id, presence: true
  def create
    @user_category = UserCategory.new(category_id, user_id)
    if @user_category.save
      return @user_category
    else
      return @user_category
    end
  end
  
end
