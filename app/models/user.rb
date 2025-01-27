class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i
  FULL_WIDTH_REGEX = /\A[ぁ-んァ-ヶ一-龥々ー]+\z/
  KATAKANA_REGEX = /\A[ァ-ヶー]+\z/

  validates :nickname, presence: true
  validates :password, format: { with: PASSWORD_REGEX, message: 'is invalid. Include both letters and numbers' }
  validates :first_name, presence: true, format: { with: FULL_WIDTH_REGEX, message: 'is invalid. Input full-width characters' }
  validates :last_name, presence: true, format: { with: FULL_WIDTH_REGEX, message: 'is invalid. Input full-width characters' }
  validates :first_name_kana, presence: true,
                              format: { with: KATAKANA_REGEX, message: 'is invalid. Input full-width katakana characters' }
  validates :last_name_kana, presence: true,
                             format: { with: KATAKANA_REGEX, message: 'is invalid. Input full-width katakana characters' }
  validates :birthday, presence: true
end
