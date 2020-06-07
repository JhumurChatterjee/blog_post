require "rails_helper"

RSpec.describe Post, type: :model do
  let!(:post)  { create(:post, archive: true, created_at: Time.now + 1.hour) }
  let!(:post1) { create(:post, archive: false, created_at: Time.now) }

  describe "active record columns" do
    it { should have_db_column(:title) }
    it { should have_db_column(:body) }
    it { should have_db_column(:user_id) }
    it { should have_db_column(:archive) }
    it { should have_db_column(:created_at) }
    it { should have_db_column(:updated_at) }
  end

  describe "active record index" do
    it { should have_db_index(:user_id) }
  end

  describe "#validations" do
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).is_at_most(255) }
    it { should validate_presence_of(:body) }
    it { should allow_value(%w(true false)).for(:archive) }
  end

  describe "#associations" do
    it { should belong_to(:user) }
  end

  describe "#order_by_date" do
    context "when we want to get records according to creation time desc" do
      it "should return records according to creation time desc" do
        expect(Post.order_by_date).to eq([post, post1])
      end
    end
  end

  describe "#archived" do
    context "when we want to get archived record" do
      it "should return archived record" do
        expect(Post.archived).to eq([post])
      end
    end
  end

  describe "#archived" do
    context "when we want to get non archived record" do
      it "should return non archived record" do
        expect(Post.non_archived).to eq([post1])
      end
    end
  end
end
