class Api::CategoriesController < Api::UsersController

  def index
    categories=Category.all
    render(json: ActiveModel::Serializer::CollectionSerializer.new(categories, serializer: Api::CategorySerializer))
  end
  def show
    category=Category.find_by_name(params[:name])
    posts=Neo4j::ActiveBase.current_session.query("
          MATCH (n:Article)-[:BELONG_TO]->(c:Category)
          WHERE c.name =~ '#{params[:name]}'
          RETURN n")
          .to_a
          .collect{|x| x.n.properties}
    render(json: {category: category, posts: posts}.to_json())
  end

  private
    def article_params
      params.require(:category).permit(:name)
    end
end
