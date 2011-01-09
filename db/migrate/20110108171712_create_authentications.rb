class CreateAuthentications < ActiveRecord::Migration
  def self.up
    create_table :authentications, :force => true do |t|
      t.string    :provider,  :required => true
      t.string    :secret,    :required => true
      t.string    :token,     :required => true
      t.integer   :user_id,   :required => true
      t.string    :uid
      t.timestamps
    end
    
    add_index :authentications, :user_id
  end

  def self.down
    drop_table :authentications
  end
end
