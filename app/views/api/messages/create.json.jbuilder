json.(@message, :content, :image)
json.created_at @message.created_at
json.user_name  @message.user.user.name
json.id         @message.id