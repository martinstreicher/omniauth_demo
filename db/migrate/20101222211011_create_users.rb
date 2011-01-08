class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users, :force => true do |t|
      t.confirmable
      t.database_authenticatable
      t.invitable
      t.recoverable
      t.rememberable
      t.trackable

      t.string    :first_name
      t.string    :last_name
      t.string    :role
      t.string    :user_name
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
