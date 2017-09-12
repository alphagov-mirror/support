require 'rails_helper'

describe AnonymousFeedbackPresenter, type: :presenter do
  context "when api_response has no `results`" do
    let(:api_response) {
      double(
        results: [],
        current_page: 1,
        pages: 1,
        page_size: 50,
        total_count: 11,
      )
    }
    subject(:presenter) { AnonymousFeedbackPresenter.new(api_response) }

    it "should be empty" do
      expect(presenter).to be_empty
    end

    it "should have zero size" do
      expect(presenter.size).to be_zero
    end

    it "should present api_response's `results` as an empty array" do
      expect(presenter).to eq([])
    end

    it "should return false for results_limited" do
      expect(presenter.results_limited).to be_falsey
    end
  end

  context "when api_response has `results`" do
    let(:api_response) {
      double(
        current_page: 2,
        pages: 9,
        page_size: 50,
        results: [{}, {}, {}],
        total_count: 444,
        results_limited: true
      )
    }
    subject(:presenter) { AnonymousFeedbackPresenter.new(api_response) }

    it "should match api_response's `results`" do
      expect(presenter.size).to eql(3)
    end

    describe "pagination" do
      it "should report `current_page`" do
        expect(presenter.current_page).to eq(2)
      end

      it "should report `total_pages`" do
        expect(presenter.total_pages).to eq(9)
      end

      it "should report `limit_value`" do
        expect(presenter.limit_value).to eq(50)
      end

      it "should return false for results_limited" do
        expect(presenter.results_limited).to be_truthy
      end
    end
  end
end
