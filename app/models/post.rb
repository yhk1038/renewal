class Post < ApplicationRecord
    belongs_to :user
    belongs_to :theme, optional: true
end
