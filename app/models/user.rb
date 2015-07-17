class User < ActiveRecord::Base
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :class_year, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1920, message: "Please enter your 4-digit class year." }
  validates :blurb, length: { maximum: 160 }, allow_blank: true
  validates :phone, allow_blank: true,  length: { is: 10 }, format: { with: /[\d\d\d\d\d\d\d\d\d\d]/ }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
