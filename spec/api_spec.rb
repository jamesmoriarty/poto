require "spec_helper"
require "poto/file_repository/aws/s3"

describe Poto::API do
  let(:bucket)   { "abc" }
  let(:key)      { "example.png" }
  let(:client) do
    instance_double("Client",
      objects: OpenStruct.new(contents: [ OpenStruct.new(key: key, size: 0) ]),
      url:     "http://example.com/example.png"
    )
  end

  subject(:app) { Poto::API.configure(repository: Poto::FileRepository::AWS::S3.new(bucket: bucket, client: client)) }

  describe "GET /files" do
    subject { get("/files") }

    before { subject }

    it { expect(last_response).to be_ok }
    it { expect(last_response_as_json).to be_json_of_files([key]) }
  end

  describe "GET /files/id" do
    subject { get("/files/" + Base64.urlsafe_encode64("example.png")) }

    before { subject }

    it { expect(last_response.location).to eq("http://example.com/example.png") }
  end
end
