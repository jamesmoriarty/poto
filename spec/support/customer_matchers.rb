RSpec::Matchers.define :be_json_of_files do |expected|
  match do |actual|
    expect(actual[:_embedded][:files].size).to eq expected.size
    expect(actual[:_links][:self]).to eq(href: "http://example.org:80/files?page=")
    expect(actual[:_links][:next]).to eq(href: "http://example.org:80/files?page=example.png&per_page=25")
  end
end
