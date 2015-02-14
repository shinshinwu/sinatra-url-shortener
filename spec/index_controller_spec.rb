require 'spec_helper'

describe "index_controller" do
  describe "GET /" do
    it "displays an empty box for user to enter url to shorten" do
    # let user create new short URL, display a list of shortened URLs
      expect(page).to have_selector("form")
      expect(response).to render_template("index")
    end
  end

end
