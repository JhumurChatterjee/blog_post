require "rails_helper"

RSpec.describe User, type: :model do
  let!(:user) { create(:user) }

  describe "active record columns" do
    it { should have_db_column(:first_name) }
    it { should have_db_column(:last_name) }
    it { should have_db_column(:email) }
    it { should have_db_column(:encrypted_password) }
    it { should have_db_column(:reset_password_token) }
    it { should have_db_column(:reset_password_sent_at) }
    it { should have_db_column(:remember_created_at) }
    it { should have_db_column(:sign_in_count) }
    it { should have_db_column(:current_sign_in_at) }
    it { should have_db_column(:last_sign_in_at) }
    it { should have_db_column(:current_sign_in_ip) }
    it { should have_db_column(:last_sign_in_ip) }
    it { should have_db_column(:confirmation_token) }
    it { should have_db_column(:confirmed_at) }
    it { should have_db_column(:confirmation_sent_at) }
    it { should have_db_column(:unconfirmed_email) }
    it { should have_db_column(:created_at) }
    it { should have_db_column(:updated_at) }
  end

  describe "active record index" do
    it { should have_db_index(:email) }
    it { should have_db_index(:reset_password_token) }
    it { should have_db_index(:confirmation_token) }
  end

  describe "#callbacks" do
    context "when first_name contains extra space and is not titleize" do
      it "should remove extra space and make titleize" do
        new_user = build(:user, first_name: " sachin   ramesh  ")
        new_user.valid?
        expect(new_user.first_name).to eq ("Sachin Ramesh")
      end
    end

    context "when last_name contains extra space and is not titleize" do
      it "should remove extra space and make titleize" do
        new_user = build(:user, last_name: " roy   chowdhury  ")
        new_user.valid?
        expect(new_user.last_name).to eq ("Roy Chowdhury")
      end
    end
  end

  describe "#validations" do
    it { should validate_presence_of(:first_name) }
    it { should validate_length_of(:first_name).is_at_most(255) }
    it { should validate_presence_of(:last_name) }
    it { should validate_length_of(:last_name).is_at_most(255) }
  end

  describe "#full_name" do
    context "when we want to get full name of the user" do
      it "should return the full name of the user" do
        full_name = "#{user.first_name} #{user.last_name}"
        expect(user.full_name).to eq(full_name)
      end
    end
  end

  describe "#initial" do
    context "when we want to get initial of the user name" do
      it "should return the initial of the user name" do
        initial = "#{user.first_name[0]}#{user.last_name[0]}"
        expect(user.initial).to eq(initial)
      end
    end
  end
end
