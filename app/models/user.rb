class User <ApplicationRecord 
  validates_presence_of :email, :name, :password_digest
  validates_uniqueness_of :email
  has_secure_password
  has_many :viewing_parties
  enum role: %w(default manager admin)
end 