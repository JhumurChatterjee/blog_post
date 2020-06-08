require "rails_helper"

RSpec.describe Comment, type: :model do
  let!(:post) { create(:post) }
  let!(:user) { create(:user) }

  describe "active record columns" do
    it { should have_db_column(:body) }
    it { should have_db_column(:title) }
    it { should have_db_column(:commentable_type) }
    it { should have_db_column(:commentable_id) }
    it { should have_db_column(:subject) }
    it { should have_db_column(:parent_id) }
    it { should have_db_column(:lft) }
    it { should have_db_column(:rgt) }
    it { should have_db_column(:user_id) }
    it { should have_db_column(:created_at) }
    it { should have_db_column(:updated_at) }
  end

  describe "active record index" do
    it { should have_db_index(:user_id) }
    it { should have_db_index([:commentable_id, :commentable_type]) }
  end

  describe "#validations" do
    it { should validate_presence_of(:body) }
  end

  describe "#associations" do
    it { should belong_to(:commentable) }
    it { should belong_to(:user) }
  end

  describe "#build_from" do
    context "when we want to get new comment object" do
      it "should return new initialized comment object" do
        expect(Comment.build_from(post, user.id, "ABC")).instance_of?(Comment)
      end
    end
  end
end
