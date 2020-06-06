require "rails_helper"

RSpec.describe ApplicationHelper, type: :helper do
  describe "#full_title" do
    context "when not passing any page title" do
      it "should return default page title" do
        expect(full_title).to eq(t("page_title"))
      end
    end

    context "when passing page title" do
      it "should return page title with default page title" do
        title = "Home"
        expect(full_title(title)).to eq("#{title} | #{t("page_title")}")
      end
    end
  end
end
