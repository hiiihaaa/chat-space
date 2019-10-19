class RenameContntColumnToMessage < ActiveRecord::Migration[5.0]
  def change
    rename_column :messages, :contnt, :content
  end
end
