require "spec_helper"

describe Poto::App do
  describe "GET /" do
    subject { get("/") }

    before { subject }

    it { expect(last_response).to be_ok }
  end
end
