class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  # foreign_key（FK）には、@user.xxxとした際に「@user.idがfollower_idなのかfollowed_idなのか」を指定します。
  has_many :relationships, foreign_key: :follower_id, dependent: :destroy
  has_many :followers, through: :relationships, source: :followed
  # @user.booksのように、@user.yyyで、
  # そのユーザがフォローしている人orフォローされている人の一覧を出したい
  has_many :reverse_of_ralationships, class_name: 'Relationship', foreign_key: :followed_id, dependent: :destroy
  has_many :followeds, through: :reverse_of_relationships, source: :follower

  def is_followed_by?(user)
    reverse_of_ralationships.find_by(follower_id: user.id).present?
  end

  attachment :profile_image, destroy: false

  validates :name, length: {maximum: 20, minimum: 2}, uniqueness: true
  validates :introduction, length: {maximum: 50}
end
