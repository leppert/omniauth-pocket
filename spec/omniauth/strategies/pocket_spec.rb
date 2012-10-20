require 'spec_helper'

describe OmniAuth::Strategies::Pocket do

  subject do
    OmniAuth::Strategies::Pocket.new({})
  end

  context "general" do
    it "should be called pocket" do
      subject.options.name.should eq('pocket')
    end
  end

  context "endpoints" do
    it "has correct site" do
      subject.options.client_options.site.should eq("https://getpocket.com")
    end

    it "has correct authorize_url" do
      subject.options.client_options.authorize_url.should eq("https://getpocket.com/auth/authorize")
    end

    it "has correct token_url" do
      subject.options.client_options.token_url.should eq("https://getpocket.com/v3/oauth/authorize")
    end
  end

end
