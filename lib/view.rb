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
      URI.encode "#{CouchCover.couchdb_url}/_design/#{@category}/_view/#{@name}#{limit_param limit}#{range startkey, endkey}"
    end

    private

    def limit_param limit
      if limit && limit > 0
        "?limit=#{limit}"
      else
        ""
      end
    end

    def startkey_param startkey
      # TODO sanitization
      startkey ? "&startkey=#{startkey}" : ""
    end

    def endkey_param endkey
      # TODO sanitization
      endkey ? "&endkey=#{endkey}" : ""
    end

    def range startkey, endkey
      "#{startkey_param startkey}#{endkey_param endkey}"
    end
  end
end
