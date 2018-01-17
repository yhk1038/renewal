class Subscribe < ApplicationRecord
    belongs_to :user
    belongs_to :target, foreign_key: 'target_id', class_name: 'User'
end
