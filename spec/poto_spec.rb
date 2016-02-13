require "spec_helper"
require "rack/test"
require "cgi"

describe Poto do
  include Rack::Test::Methods

  def app
    described_class
  end

  it "has a version number" do
    expect(Poto::VERSION).not_to be nil
  end

  describe Poto::App do
    describe "GET /" do
      subject { get("/") }

      before { subject }

      it { expect(last_response).to be_ok }
    end
  end

  describe Poto::ImageProxy do
    describe "GET /" do
      let(:fixtures_path) { File.expand_path("fixtures", File.dirname(__FILE__)) }
      let(:port)          { 3003 }
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

  describe Poto::API do
    let(:bucket)   { "abc" }
    let(:key)      { "example.png" }
    let(:client) do
      instance_double("S3Client",
        list_objects:  OpenStruct.new(contents: [ OpenStruct.new(key: key, size: 0) ]),
        presigned_url: "http://example.com/"
      )
    end

    subject(:app) { Poto::API.new(Poto::FileRepository::S3Repository.new(bucket: bucket, client: client)) }

    describe "GET /files" do
      subject { get("/files") }

      before { subject }

      it { expect(last_response).to be_ok }
      it { expect(last_response_as_json).to be_json_of_files([key]) }
    end
  end
end
