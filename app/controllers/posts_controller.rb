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
              RETURN DISTINCT (n)").to_a
    else
      @posts= Neo4j::ActiveBase.current_session.query("MATCH (n:Article) RETURN n") .to_a
    end
  end

  def show
    @post= Neo4j::ActiveBase.current_session.query("MATCH (n:Article) WHERE ID(n)=#{params[:id]} RETURN n").to_a[0]
  end

end
