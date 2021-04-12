class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username, nil: false
      t.string :password_d, nil: false
      t.string :session_token, nil: false
    end
  end
end
