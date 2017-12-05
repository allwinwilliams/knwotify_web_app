class CategoriesController < UsersController

  def index
    @categories=Category.all
    @user_category_ids=current_user.subscribed_category_ids()
  end

  def show
    @category=Category.find_by_name(params[:name])
    @posts=Neo4j::ActiveBase.current_session.query("MATCH (n:Article)-[:BELONG_TO]->(c:Category) WHERE c.name='#{params[:name]}' RETURN n").to_a
  end

  private
    def article_params
      params.require(:category).permit(:name)
    end
end
