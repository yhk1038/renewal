class Action::ViewCountsController < ApplicationController
    before_action :set_view_count, only: [:show, :edit, :update, :destroy]

    # GET /view_counts
    # GET /view_counts.json
    def index
        @view_counts = ViewCount.all
    end

    # GET /view_counts/1
    # GET /view_counts/1.json
    def show
    end

    # GET /view_counts/new
    def new
        @view_count = ViewCount.new
    end

    # GET /view_counts/1/edit
    def edit
    end

    # POST /view_counts
    # POST /view_counts.json
    def create
        @view_count = ViewCount.new(view_count_params)

        respond_to do |format|
            if @view_count.save
                format.html {redirect_to @view_count, notice: 'View count was successfully created.'}
                format.json {render json: @view_count, status: :created}
            else
                format.html {render :new}
                format.json {render json: @view_count.errors, status: :unprocessable_entity}
            end
        end
    end

    # PATCH/PUT /view_counts/1
    # PATCH/PUT /view_counts/1.json
    def update
        respond_to do |format|
            if @view_count.update(view_count_params)
                format.html {redirect_to @view_count, notice: 'View count was successfully updated.'}
                format.json {render json: @view_count, status: :ok}
            else
                format.html {render :edit}
                format.json {render json: @view_count.errors, status: :unprocessable_entity}
            end
        end
    end

    # DELETE /view_counts/1
    # DELETE /view_counts/1.json
    def destroy
        @view_count.destroy
        respond_to do |format|
            format.html {redirect_to view_counts_url, notice: 'View count was successfully destroyed.'}
            format.json {render json: @view_count, status: :ok}
        end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_view_count
        pa = params[:view_count]
        @view_count = params[:id].to_i.zero? ? ViewCount.where(user_id: pa[:user_id], post_id: pa[:post_id]).take : ViewCount.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def view_count_params
        params.require(:view_count).permit(:user_id, :post_id)
    end
end
