module Coinigy
  # Represents an Account of a user subscription to Coinigy
  class Market < Coinigy::Model
    attr_accessor :exch_id, :exch_name, :exch_code, :mkt_id, :mkt_name, :exchmkt_id

    # Relations
    attr_accessor :exchange

    def attributes
      { 'exch_id' => exch_id,
        'exch_name' => exch_name,
        'exch_code' => exch_code,
        'mkt_id' => mkt_id,
        'mkt_name' => mkt_name,
        'exchmkt_id' => exchmkt_id }
    end
  end
end
