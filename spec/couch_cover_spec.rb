require 'spec_helper'

describe CouchCover do
  it 'has a version number' do
    expect(CouchCover::VERSION).not_to be nil
  end
end

describe CouchCover::View do
  it 'can be initialized' do
    CouchCover::View.new 'is', 'init'
  end

  it 'constructs correct URIs with implicit limit' do
    CouchCover.couchdb_url="http://couch"
    uri = CouchCover::View.new('a','view').view_url
    expect(uri.to_s).to eql "http://couch/_design/a/_view/view?limit=20"
  end

  it 'construct URIs with start_key' do
    CouchCover.couchdb_url="http://couch"
    uri = CouchCover::View.new('a','view').view_url "2014", "2011"
    expect(uri.to_s).to eql "http://couch/_design/a/_view/view?limit=20&startkey=2014&endkey=2011"
  end

  it 'construct URIs with start_key also with weird characters' do
    CouchCover.couchdb_url="http://couch"
    uri = CouchCover::View.new('a','view').view_url "2014", "[2011]"
    expect(uri.to_s).to eql "http://couch/_design/a/_view/view?limit=20&startkey=2014&endkey=[2011]"
  end
  it 'construct URIs with start_key that needs escaping' do
    CouchCover.couchdb_url="http://couch"
    uri = CouchCover::View.new('a','view').view_url "2014", "[2011]"
    expect(uri.to_s).to eql "http://couch/_design/a/_view/view?limit=20&startkey=2014&endkey=[2011]"
  end
end

describe CouchCover::URIParameter do
  it 'constructs simple valid parameter string' do
    params = CouchCover::URIParameter.construct(startkey: "[2014]")
    expect(params).to eq "?startkey=[2014]"
  end
end
