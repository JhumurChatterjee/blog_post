require "rails_helper"

RSpec.describe Comment, type: :model do
  let!(:comment)  { create(:comment, archive: true, created_at: Time.now + 1.hour) }
  let!(:comment1) { create(:comment, archive: false, created_at: Time.now) }

  describe "active record columns" do
    it { should have_db_column(:content) }
    it { should have_db_column(:post_id) }
    it { should have_db_column(:archive) }
    it { should have_db_column(:created_at) }
    it { should have_db_column(:updated_at) }
  end

  describe "active record index" do
    it { should have_db_index(:post_id) }
  end

  describe "#validations" do
    it { should validate_presence_of(:content) }
    it { should allow_value(%w(true false)).for(:archive) }
  end

  describe "#associations" do
    it { should belong_to(:post) }
  end

  describe "#order_by_date" do
    context "when we want to get records according to creation time desc" do
      it "should return records according to creation time desc" do
        expect(Comment.order_by_date).to eq([comment, comment1])
      end
    end
  end

  describe "#archived" do
    context "when we want to get archived record" do
      it "should return archived record" do
        expect(Comment.archived).to eq([comment])
      end
    end
  end

  describe "#archived" do
    context "when we want to get non archived record" do
      it "should return non archived record" do
        expect(Comment.non_archived).to eq([comment1])
      end
    end
  end
end
