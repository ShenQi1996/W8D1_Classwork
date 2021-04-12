class User < ApplicationRecord

    validates :username, :password_d, :session_token, presence: true
    validates :session_token, uniqueness: true
    validates :password, length: {minimum: 6, allow_nil: true}

    before_validation :ensure_session_token

    attr_reader :password

    has_many :subs,
        foreign_key: :moderator_id,
        class_name: :Sub

    has_many :posts,
        foreign_key: :author_id,
        class_name: :Post

    def password=(password)
        @password = password
        self.password_d = BCrypt::Password.create(password)
    end

    def self.make_session_token
        SecureRandom.urlsafe_base64
    end

    def ensure_session_token
        self.session_token ||= User.make_session_token
    end

    def reset_session_token
        self.session_token = User.make_session_token
        self.save!
        self.session_token
    end

    def self.find_by_c(username, password)
        @user = User.find_by(username: username)
        if @user && @user.is_password?(password)
            @user
        else
            nil
        end
    end

    def is_password?(password)
        obj = BCrypt::Password.new(self.password_d)
        obj.is_password?(password)
    end
end