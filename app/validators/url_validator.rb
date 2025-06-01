require 'uri'

class UrlValidator < ActiveModel::EachValidator
  def self.compliant?(value)
    uri = URI.parse(value)
    uri.is_a?(URI::HTTP) || uri.is_a?(URI::HTTPS)
  rescue URI::InvalidURIError
    false
  end

  def validate_each(record, attribute, value)
    unless self.class.compliant?(value)
      record.errors.add(attribute, options[:message] || "is not a valid URL")
    end
  end
end
