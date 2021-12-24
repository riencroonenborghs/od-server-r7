class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, and :omniauthable
  # :registerable, :recoverable
  devise :database_authenticatable, :rememberable, :validatable, :trackable

  has_many :downloads, dependent: :destroy
  has_many :wget_downloads, dependent: :destroy, class_name: "WgetDownload"
end
