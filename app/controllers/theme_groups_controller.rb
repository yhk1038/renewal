class ThemeGroupsController < ApplicationController
    before_action :set_theme_group, only: [:show, :edit, :update, :destroy]
    before_action -> { valid_user @theme_groups }, except: [:index, :show, :new]
    before_action :set_layout_variables
    before_action except: [:destroy] { set_layout [false, false, false] }

    # GET /theme_groups
    # GET /theme_groups.json
    def index
        @theme_groups = ThemeGroup.all
    end

    # GET /theme_groups/1
    # GET /theme_groups/1.json
    def show
    end

    # GET /theme_groups/new
    def new
        @theme_group = ThemeGroup.new
    end

    # GET /theme_groups/1/edit
    def edit
    end

    # POST /theme_groups
    # POST /theme_groups.json
    def create
        @theme_group = ThemeGroup.new(theme_group_params)

        respond_to do |format|
            if @theme_group.save
                format.html {redirect_to @theme_group, notice: 'Theme group was successfully created.'}
                format.json {render :show, status: :created, location: @theme_group}
            else
                format.html {render :new}
                format.json {render json: @theme_group.errors, status: :unprocessable_entity}
            end
        end
    end

    # PATCH/PUT /theme_groups/1
    # PATCH/PUT /theme_groups/1.json
    def update
        respond_to do |format|
            if @theme_group.update(theme_group_params)
                format.html {redirect_to @theme_group, notice: 'Theme group was successfully updated.'}
                format.json {render :show, status: :ok, location: @theme_group}
            else
                format.html {render :edit}
                format.json {render json: @theme_group.errors, status: :unprocessable_entity}
            end
        end
    end

    # DELETE /theme_groups/1
    # DELETE /theme_groups/1.json
    def destroy
        @theme_group.destroy
        respond_to do |format|
            format.html {redirect_to theme_groups_url, notice: 'Theme group was successfully destroyed.'}
            format.json {head :no_content}
        end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_theme_group
        @theme_group = ThemeGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def theme_group_params
        params.require(:theme_group).permit(:title, :description, :link)
    end
end
