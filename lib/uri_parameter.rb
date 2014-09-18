module CouchCover
  module URIParameter
    # Construct URI parameter for e.g. GET requests, rejecting
    # nil values in params (which is a hash).
    def self.construct_nonil params
      nonil_params = params.delete_if {|k,v| v.nil?}
      construct nonil_params
    end

    # Construct URI parameter for e.g. GET requests, accepting
    # nil values in params (which is a hash).
    def self.construct params
      uri_params = params.map {|k,v| "#{k}=#{v}"}.join("&")
      if !uri_params.empty?
        "?#{uri_params}"
      else
        ""
      end
    end
  end
end
