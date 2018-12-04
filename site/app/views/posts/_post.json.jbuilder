json.extract! post, :id, :titulo, :categoria, :texto, :user_id, :created_at, :updated_at
json.url post_url(post, format: :json)
