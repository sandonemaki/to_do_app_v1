# new専用のクラス
class PresenterNew

  # attr_reader :content, :errors
  def initialize(content:, errors: {})
    @content = content #String or nil
    @errors = errors #Hash
  end

  def content
    return @content
  end

  def errors
    @errors
  end
end
