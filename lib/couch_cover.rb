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
    def self.get_doc doc_id
      uri = URI.encode "#{CouchCover.couchdb_url}/#{doc_id}"
      RestClient.get uri
    end
  end

  def self.couchdb_url= new_url
    @@couchdb_url = new_url
  end

  def self.couchdb_url
    @@couchdb_url
  end

  # opts can be
  #  - :from ([2014,31,12]) the start key (date)
  #  - :limit the max number of entries to fetch
  def self.get_seminars opts=nil
    opts = {limit:20}.merge opts
    if opts && opts[:from]
      CouchDB.view('api', 'seminar_by_date').query(opts[:from], nil, opts[:limit])
    else
      CouchDB.view('api', 'seminar_by_date').query(nil, nil, opts[:limit])
    end
  end

  def self.get_bookings_for_seminar seminar_uuid
    CouchDB.view('sl_seminar', 'booking_by_seminar').query(seminar_uuid, seminar_uuid, nil)
  end
end
