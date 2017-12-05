class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :user_category, class_name:  "UserCategory",
                                  foreign_key: "user_id",
                                  dependent:   :destroy
  def is_subscribed(category)
    user_category=UserCategory.where(:user_id => self.id,:category_id => category.id)
    if user_category.blank?
      return false
    else
      return true
    end
  end
  def subscribed_category_ids()
    return UserCategory.where(:user_id => self.id).collect{ |x| x.category_id }
  end
end
