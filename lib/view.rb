require 'couch_cover'

module CouchCover

  class View
    attr_accessor :category
    attr_accessor :name

    def initialize category, name
      @category = category
      @name = name
    end

    def query startkey=nil, endkey=nil, limit=20
      # respect limit
      RestClient.get view_url startkey, endkey, limit
    end

    def view_url startkey=nil, endkey=nil, limit=20
      params = URIParameter.construct_nonil(limit: limit,
        startkey: startkey, endkey: endkey)

      URI.encode "#{CouchCover.couchdb_url}/_design/#{@category}/_view/#{@name}#{params}"
    end
  end
end
