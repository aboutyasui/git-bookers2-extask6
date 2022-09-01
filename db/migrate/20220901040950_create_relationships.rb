class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      t.integer :follower_id #フォローするユーザのid
      t.integer :followed_id #フォローされるユーザのid

      t.timestamps
    end
    
    add_index :relationships, :follower_id 
    add_index :relationships, :followed_id 
    add_index :relationships,  [:follower_id, :followed_id], unique: true #同じ人を２回３回フォローできないようにする
    
  end
end
