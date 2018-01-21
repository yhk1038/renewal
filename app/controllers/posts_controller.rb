class PostsController < ApplicationController
    before_action :is_login?, except: [:index, :show]
    before_action :set_post, only: [:show, :edit, :update, :destroy]
    before_action -> { valid_user @post }, except: [:index, :show, :create, :edit]
    before_action :set_layout_variables
    before_action except: [:destroy] { set_layout [false, false, false] }
    after_action :increase_view_count, only: [:show]

    # GET /posts
    # GET /posts.json
    def index
        @posts = Post.all
    end

    # GET /posts/1
    # GET /posts/1.json
    def show
        @theme = @post.theme
        @posts = @theme.posts.reverse - [@post]
    end

    # GET /posts/new
    def new
        @post = Post.new
    end

    # GET /posts/1/edit
    def edit
    end

    # POST /posts
    # POST /posts.json
    def create
        @post = Post.new(post_params)

        respond_to do |format|
            if @post.save
                format.html {redirect_to @post, notice: 'Post was successfully created.'}
                format.json {render :show, status: :created, location: @post}
            else
                format.html {render :new}
                format.json {render json: @post.errors, status: :unprocessable_entity}
            end
        end
    end

    # PATCH/PUT /posts/1
    # PATCH/PUT /posts/1.json
    def update
        respond_to do |format|
            if @post.update(post_params)
                format.html {redirect_to @post, notice: 'Post was successfully updated.'}
                format.json {render :show, status: :ok, location: @post}
            else
                format.html {render :edit}
                format.json {render json: @post.errors, status: :unprocessable_entity}
            end
        end
    end

    # DELETE /posts/1
    # DELETE /posts/1.json
    def destroy
        @post.destroy
        respond_to do |format|
            format.html {redirect_to posts_url, notice: 'Post was successfully destroyed.'}
            format.json {head :no_content}
        end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
        @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
        params.require(:post).permit(:content_type, :runtime, :title, :thumbnail_img, :video_url, :user_id, :theme_id)
    end

    def increase_view_count
        if user_signed_in?
            ViewCount.create(post: @post, user: current_user)
        end
    end
end
