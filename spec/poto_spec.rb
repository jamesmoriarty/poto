require "spec_helper"
require "rack/test"

describe Poto do
  include Rack::Test::Methods

  def app
    described_class
  end

  it "has a version number" do
    expect(Poto::VERSION).not_to be nil
  end

  describe Poto::API do
    let(:client) { Aws::S3::Client.new(stub_responses: true) }
    let(:bucket) { "abc" }

    before do
      ENV["AWS_S3_BUCKET"] = bucket
      allow_any_instance_of(Poto::FileRepository::S3Repository)
        .to receive(:client)
          .and_return(client)
    end

    describe "GET /files" do
      subject { get("/files") }

      before { subject }

      it { expect(last_response).to be_ok }
      it { expect(last_response_as_json).to be_json_of_files([]) }
    end
  end
end
