require 'rails_helper'

RSpec.describe "コンセプトページ", type: :request do
  describe "GET #index" do
    before do
      get concepts_path
    end

    it "リクエストが成功すること" do
      expect(response).to have_http_status(200)
    end
  end
end
