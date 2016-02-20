require "spec_helper"
require "poto/file_repository/s3_repository"

describe Poto::API do
  let(:bucket)   { "abc" }
  let(:key)      { "example.png" }
  let(:client) do
    instance_double("Client",
      objects: OpenStruct.new(contents: [ OpenStruct.new(key: key, size: 0) ]),
      url:     "http://example.com/"
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
