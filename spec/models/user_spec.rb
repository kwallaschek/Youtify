require 'rails_helper'

RSpec.describe User, type: :model do
  def create_a_user(email: "#{SecureRandom.hex(4)}@example.org")
    User.create!(
      username: "test",
      email: email,
      password: "test",
    )
  end

  describe "#valid?" do
    it "is valid when email is unique" do
      create_a_user
    user = User.new
      user.username = "tests"
    user.email = "test@example.org"
      user.password = "test"
    expect(user.valid?).to be true
    end

    it "is invalid if email is taken" do
      create_a_user(email: "test@test.com")
      user = User.new
      user.username = "test2"
      user.email = "test@test.com"
      user.password = "test"
      expect(user.valid?).not_to be true
    end

    it "is invalid if username is taken" do
      create_a_user(email: "test@test.com")
      user = User.new
      user.username = "test"
      user.email = "test2@test.com"
      user.password = "test"
      expect(user.valid?).not_to be true
    end

    it "is invalid if username is blank" do
      user = create_a_user
      expect(user).to be_valid

      user.username = ""
      expect(user).not_to be_valid

      user.username = nil
      expect(user).not_to be_valid
    end

    it "is invalid no valid email is given" do
      user = create_a_user
      expect(user).to be_valid

      user.email = "bla"
      expect(user).to be_invalid

      user.email = "bla@"
      expect(user).to be_invalid

      user.email = "bla.co"
      expect(user).to be_invalid

      user.email = "bla@asdf"
      expect(user).to be_invalid

      user.email = "bla@fds.sdf.d"
      expect(user).to be_valid
    end
  end
end
