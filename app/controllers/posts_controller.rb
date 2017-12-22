class PostsController < UsersController

  def index
    puts "posts controller....."
    if params[:q] && params[:q]!=""
      @posts= Neo4j::ActiveBase.current_session.query(
              "MATCH (n:Article)-[:BELONG_TO]->(c:Category)
              WHERE
              c.name CONTAINS '#{params[:q]}'
              or n.content CONTAINS '#{params[:q]}'
              or n.title CONTAINS '#{params[:q]}'
              RETURN DISTINCT (n)")
              .to_a
              .paginate(:page => params[:page], :per_page => 5)
    else
      @posts= Neo4j::ActiveBase.current_session.
              query("MATCH (n:Article) RETURN n")
              .to_a
              .paginate(:page => params[:page], :per_page => 5)
    end
    
    @page = (params[:page] || 1).to_i
  end

  def show
    @post= Neo4j::ActiveBase.current_session.query("MATCH (n:Article) WHERE ID(n)=#{params[:id]} RETURN n").to_a[0]
  end

end
