class PostsController < UsersController

  def index
    if params[:q] && params[:q]!=""
      @all_posts=Neo4j::ActiveBase.current_session.query(
              "MATCH (n:Article)-[:BELONG_TO]->(c:Category)
              WHERE
              c.name CONTAINS '#{params[:q]}'
              or n.content CONTAINS '#{params[:q]}'
              or n.title CONTAINS '#{params[:q]}'
              RETURN DISTINCT (n)")
              .to_a
      @posts=@all_posts
              .paginate(:page => params[:page], :per_page => 5)
    else
      @all_posts=Neo4j::ActiveBase.current_session.
              query("MATCH (n:Article) RETURN n")
              .to_a
      @posts=@all_posts
              .paginate(:page => params[:page], :per_page => 5)
    end

    if params[:page]
      @page=params[:page].to_i
    else
      @page=1
    end
    @total_pages = ( @all_posts.length%5 == 0 ) ? @all_posts.length/5 : @all_posts.length/5+1
  end

  def show
    @post= Neo4j::ActiveBase.current_session.query("MATCH (n:Article) WHERE ID(n)=#{params[:id]} RETURN n").to_a[0]
  end

end
