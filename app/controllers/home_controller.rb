class HomeController < ApplicationController
    before_action :set_layout_variables

    def index
        # Hot Theme:        Themes * 3
        # Hot Channel:      Themes * 5
        # Theme Recommend:  Themes * 10
        hot_themes          = []
        hot_channels        = []
        recommend_themes    = []
        @theme_groups = [ThemeGroup.find(3)]
    end
end
