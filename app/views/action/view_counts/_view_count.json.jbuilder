json.extract! view_count, :id, :user_id, :post_id, :created_at, :updated_at
json.url view_count_url(view_count, format: :json)
