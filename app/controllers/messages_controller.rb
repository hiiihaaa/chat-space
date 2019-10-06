class MessagesController < ApplicationController
  def index
    @username = "name"
    @group_name = "グループ名"
    @latest_message = "最新のコメント"
    # @message ＝1 ##インスタンス
    @current_group_name = "現在のグループ名"
    @member_name = "メンバーの名前"
    @tolker = "tolker"
    @date =  "日付"
    @message_text = "メッセージ"

  end
end