class ThemesController < ApplicationController
    before_action :set_theme, only: [:show, :edit, :update, :destroy]
    before_action :set_layout_variables

    # GET /themes
    # GET /themes.json
    def index
        @layout_carousel_display = false
        @navbar_transparent = false
        @theme_groups = ThemeGroup.all
    end

    # GET /themes/1
    # GET /themes/1.json
    def show
        set_layout [false, false, true]
        @carousels = [
            {
                id: 1,
                about:      ['', @theme.theme_group.title],
                background_img: @theme.background_img ? @theme.background_img : @theme.posts.last.thumbnail_img,
                href: 'javascript:;',
                title: @theme.title,
                subtitle:   ['', '김상윤 신송중학교 2년'],
                produce:    ['제작 : ', "#{@theme.user.name} 외 1명", ' <br>'],
                when:       ['시간 : ', @theme.updated_at.strftime('%Y. %m. %d.')],
                where:      [' , 장소 : ', '서울시 세바시 강연장']
            }
        ]
        @prev, @next = @theme.prev, @theme.next
    end

    # GET /themes/new
    def new
        @theme = Theme.new
    end

    # GET /themes/1/edit
    def edit
    end

    # POST /themes
    # POST /themes.json
    def create
        @theme = Theme.new(theme_params)

        respond_to do |format|
            if @theme.save
                format.html { redirect_to @theme, notice: 'Theme was successfully created.' }
                format.json { render :show, status: :created, location: @theme }
            else
                format.html { render :new }
                format.json { render json: @theme.errors, status: :unprocessable_entity }
            end
        end
    end

    # PATCH/PUT /themes/1
    # PATCH/PUT /themes/1.json
    def update
        respond_to do |format|
            if @theme.update(theme_params)
                format.html { redirect_to @theme, notice: 'Theme was successfully updated.' }
                format.json { render :show, status: :ok, location: @theme }
            else
                format.html { render :edit }
                format.json { render json: @theme.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /themes/1
    # DELETE /themes/1.json
    def destroy
        @theme.destroy
        respond_to do |format|
            format.html { redirect_to themes_url, notice: 'Theme was successfully destroyed.' }
            format.json { head :no_content }
        end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_theme
        @theme = Theme.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def theme_params
        params.require(:theme).permit(:title, :background_img, :thumbnail_img)
    end
end
