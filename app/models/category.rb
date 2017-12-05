class Category < ApplicationRecord
  validates :name, presence: true
  has_many :user_category, class_name:  "UserCategory",
                                  foreign_key: "category_id",
                                  dependent:   :destroy
  def create(name)
    @category = Category.new(name)
    if @category.save
      return @category
    else
      return @category
    end
  end

end
