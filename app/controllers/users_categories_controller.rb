class UsersCategoriesController < UsersController
  def index
    @user_categories=UserCategory
                    .select('categories.name')
                    .joins(:category)
                    .where('users_categories.user_id' => current_user.id)


    @posts=Neo4j::ActiveBase.current_session.query("
            MATCH (n:Article)-[:BELONG_TO]->(c:Category)
            WHERE ANY
              (x IN #{@user_categories.collect{|x| x.name}} WHERE x =~ c.name)
            RETURN n").to_a

    @category=Category.new
  end


  def categories
    @user_categories=UserCategory
                    .select('categories.name')
                    .joins(:category)
                    .where('users_categories.user_id' => current_user.id)
    @category=Category.new
  end

  def subscribe_category
    category=Category.find_by_name(user_category_params[:name]) || Category.create(name: user_category_params[:name])
    user_category =UserCategory.create(category_id: category.id, user_id: current_user.id)
    redirect_back(fallback_location: root_path)
  end

  def unsubscribe_category
    category = Category.find_by_name(user_category_params[:name])
    user_category =UserCategory.where(category_id: category.id, user_id: current_user.id)
    UserCategory.destroy(user_category.ids)
    redirect_back(fallback_location: root_path)
  end

  private
   def user_category_params
     params.require(:category).permit(:name)
   end

end
