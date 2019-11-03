json.(@message, :content, :image)
json.created_at @message.created_at
json.user_name @message.user.user_name
json.id @message.id