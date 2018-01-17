class Action::SubscribesController < ApplicationController
    before_action :set_subscribe, only: [:show, :edit, :update, :destroy]

    # GET /subscribes
    # GET /subscribes.json
    def index
        @subscribes = Subscribe.all
    end

    # GET /subscribes/1
    # GET /subscribes/1.json
    def show
    end

    # GET /subscribes/new
    def new
        @subscribe = Subscribe.new
    end

    # GET /subscribes/1/edit
    def edit
    end

    # POST /subscribes
    # POST /subscribes.json
    def create
        @subscribe = Subscribe.new(subscribe_params)

        respond_to do |format|
            if @subscribe.save
                format.html {redirect_to @subscribe, notice: 'Subscribe was successfully created.'}
                format.json {render json: @subscribe, status: :created}
            else
                format.html {render :new}
                format.json {render json: @subscribe.errors, status: :unprocessable_entity}
            end
        end
    end

    # PATCH/PUT /subscribes/1
    # PATCH/PUT /subscribes/1.json
    def update
        respond_to do |format|
            if @subscribe.update(subscribe_params)
                format.html {redirect_to @subscribe, notice: 'Subscribe was successfully updated.'}
                format.json {render json: @subscribe, status: :ok}
            else
                format.html {render :edit}
                format.json {render json: @subscribe.errors, status: :unprocessable_entity}
            end
        end
    end

    # DELETE /subscribes/1
    # DELETE /subscribes/1.json
    def destroy
        @subscribe.destroy
        respond_to do |format|
            format.html {redirect_to subscribes_url, notice: 'Subscribe was successfully destroyed.'}
            format.json {render json: @subscribe, status: :ok}
        end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_subscribe
        pa = params[:subscribe]
        @subscribe = params[:id].to_i.zero? ? Subscribe.where(user_id: pa[:user_id], target_id: pa[:target_id]).take : Subscribe.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def subscribe_params
        params.require(:subscribe).permit(:user_id, :target_id)
    end
end
