require "spec_helper"

describe Poto::ImageProxy do
  describe "GET /" do
    let(:fixtures_path) { File.expand_path("fixtures", File.dirname(__FILE__)) }
    let(:port)          { 3000 + rand(1000) }
    let(:width)         { 500 }
    let(:height)        { 500 }
    let(:src)           { "http://localhost:#{port}/example.png" }

    subject(:request) { get("/?width=#{width}&height=#{height}&src=#{CGI.escape(src)}") }

    before do
      http_server(port, fixtures_path) do
        request
      end
    end

    it { expect(last_response).to be_ok }

    context "return resized image" do
      subject(:image) { MiniMagick::Image.read(request.body) }

      it { expect(image.type).to eq "PNG" }
      it { expect(image.width).to eq 500 }
      it { expect(image.height).to eq 375 }
    end
  end
end
