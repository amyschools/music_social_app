class User < ActiveRecord::Base
  before_save :capitalize_names
  resourcify

  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]
  # Relationship

  has_many :active_relationships,  class_name:  "Relationship", foreign_key: "follower_id", dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship", foreign_key: "followed_id", dependent:   :destroy
  has_many :following, through: :active_relationships,  source: :followed
  has_many :followers, through: :passive_relationships, source: :follower




  #commontator
  acts_as_commontator
  acts_as_commontable


  acts_as_messageable


# membership/organizer relationship
has_many :bandtogethers_as_organizer, :class_name => 'Bandtogether', :foreign_key => 'organizer_id', dependent: :destroy
has_many :bandtogethers, through: :memberships
has_many :memberships, dependent: :destroy

  #paperclip

has_many :pictures, dependent: :destroy

  has_attached_file :avatar, :styles => { :large => "300x300>", :medium => "90x90>", :thumb => "50x50#"}, :default_url => "/images/:style/default_avatar.jpg"

  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/


  # validations
  validates :first_name, length: { minimum: 2 }
  validates :last_name, length: { minimum: 2 }

  validates_presence_of :first_name
  validates_presence_of :last_name


  def capitalize_names
    self.first_name = first_name.camelcase
    self.last_name = last_name.camelcase
  end


  # helpers methods

  # Follows a user.
  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  # Unfollows a user.
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # Returns true if the current user is following the other user.
  def following?(other_user)
    following.include?(other_user)
  end

  attr_accessor :current_password

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.first_name = auth.info.first_name   # assuming the user model has a name
      user.last_name = auth.info.last_name

      # user.image = auth.info.image # assuming the user model has an image
    end
  end

  def mailboxer_email(object)
    email
  end


end
