require 'parser_util'

class Parser
  include Parser::Util

  attr_reader :rants

  def initialize(str)
    @rants = extract(str)
  end
end
