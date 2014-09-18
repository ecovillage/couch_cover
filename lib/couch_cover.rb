require "couch_cover/version"
require "uri_parameter"
require 'view'

require 'json'
require 'uri'

require 'rest_client'

module CouchCover
  class CouchDB
    def self.view category, name
      View.new category, name
    end

  end

  #@@couchdb_url = nil

  def self.couchdb_url= new_url
    @@couchdb_url = new_url
  end

  def self.couchdb_url
    @@couchdb_url
  end

  def self.get_seminars opts=nil
    if opts && opts[:from]
      CouchDB.view('api', 'seminar_by_date').query(opts[:from])
    else
      CouchDB.view('api', 'seminar_by_date').query()
    end
  end
end
