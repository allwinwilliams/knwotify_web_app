class Api::PostsController < Api::UsersController
  def index
    if params[:q] && params[:q]!=""
      posts= Neo4j::ActiveBase.current_session.query(
              "MATCH (n:Article)-[:BELONG_TO]->(c:Category)
              WHERE
              c.name CONTAINS '#{params[:q]}'
              or n.content CONTAINS '#{params[:q]}'
              or n.title CONTAINS '#{params[:q]}'
              RETURN DISTINCT (n)")
              .to_a
              .collect{|x| x.n.properties }

    else
      posts= Neo4j::ActiveBase.current_session.query("MATCH (n:Article) RETURN n")
            .to_a
            .collect{|x| x.n.properties }
    end
    render(json: {posts: posts})
    #render(json: ActiveModel::Serializer::CollectionSerializer.new(posts, serializer: Api::PostSerializer))
    # render(json: Api::PostsSerializer.new(posts).to_json)
  end

  def show
    post= Neo4j::ActiveBase.current_session.query("MATCH (n:Article) WHERE ID(n)=#{params[:id]} RETURN n").to_a[0]
    render( json: post.to_json())
  end
end
