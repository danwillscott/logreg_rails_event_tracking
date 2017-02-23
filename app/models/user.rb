class User < ApplicationRecord
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  has_secure_password
  has_many :events, dependent: :destroy
  has_many :messages, dependent: :destroy
  validates :first_name, :last_name, presence: true, length: {minimum: 2}
  validates :location, :state, presence: true
  validates :email, presence: true, format: { with: EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: {minimum: 6},
            if: :password_digest_changed?
  validates_confirmation_of :password_confirmation, message: 'Password must match'

  before_save do
    self.first_name.capitalize!
    self.last_name.capitalize!
    self.email.downcase!
  end

  # TODO this has be turned to make NEW not save to alow for testing of errors and not errors
  def self.register(data)
    user = User.new(first_name: data[:first_name], last_name: data[:last_name],
                    email: data[:email], password: data[:password],
                    state: data[:state], location: data[:location],
                    password_confirmation: data[:password_confirmation])
  end

  # Fully tested login function returns errors for errors and other nice things
  def self.log_in(data)
    user = User.find_by_email(data[:email])
    if user != nil
      if user.authenticate(data[:password])
        return {truth: true, first_name: user.first_name,
                last_name: user.last_name,id: user.id, email: user.email,
                state: user.state, location: user.location}
      else
        puts '***** USER ERRORS ***** '
        return {truth: false, errors: 'Email and password do not match'}
      end
    else
      return {truth: false, errors: 'Email Not Registered'}
    end

  end

  def remove_user(data)
    user_id = User.find(data[:id])
    user_email = User.find_by_email(data[:email])
    if user_id == user_email and user_id != nil
      user_id.destroy
    else
      {errors: 'Could not delete profile, Did you modify something?'}
    end
  end

  def update_user
  end

  def self.user_state(data)
    user_state = User.all

    # user_state.where(:state == data[:state])

  end

  def self.other_state(data)

  end

end


#
# def self.log_in(data)
#   if User.find_by_email(data[:email])
#     user = User.find_by_email(data[:email])
#     user.authenticate(data[:password]).valid?
#   else
#     'Email is not registered'
#   end
# end
