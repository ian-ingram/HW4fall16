class User < ActiveRecord::Base
    #validates :user_id, uniqueness: true
    
    def User::create_user! hash
        sess_token=SecureRandom.base64 
        new_hash=hash.require(:user).permit(:user_id, :email).merge(session_token: sess_token)
        @user=User.create!(new_hash)
    end
end