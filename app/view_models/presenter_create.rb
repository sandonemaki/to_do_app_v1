class PresenterCreate

  attr_reader :content, :errors
  def initialize(content:, errors: {})
    @content = content #String or nil
    @errors = errors #Hash
  end
end

