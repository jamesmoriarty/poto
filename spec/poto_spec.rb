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
      let(:root_path) { File.expand_path("fixtures", File.dirname(__FILE__)) }
      let(:width)     { 500 }
      let(:height)    { 500 }
      let(:src)       { "http://localhost:3000/example.png" }

      subject(:request) { get("/?width=#{width}&height=#{height}&src=#{CGI.escape(src)}") }

      before do
        http_server(3000, root_path) do |server|
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
    let(:bucket) { "abc" }
    let(:key)    { "example.png" }
    let(:object) { Aws::S3::Object.new(bucket, "example.png", stub_responses: true) }
    let(:client) { Aws::S3::Client.new(stub_responses: true) }

    before do
      allow_any_instance_of(Poto::FileRepository::S3Repository::FileMapper)
        .to receive(:client)
          .and_return(object)

      allow_any_instance_of(Poto::FileRepository::S3Repository)
        .to receive(:client)
          .and_return(client)

      allow_any_instance_of(Poto::FileRepository::S3Repository)
        .to receive(:bucket)
          .and_return(bucket)

      client.stub_responses(:list_objects, contents:[{ key: key, size: 0 }])
    end

    describe "GET /files" do
      subject { get("/files") }

      before { subject }

      it { expect(last_response).to be_ok }
      it { expect(last_response_as_json).to be_json_of_files([key]) }
    end
  end
end
