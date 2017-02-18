class ChangeDefaultValueOfStatus < ActiveRecord::Migration
  def change
    change_column_default :tasks, :status, to: false
  end
end
