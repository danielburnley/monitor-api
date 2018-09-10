# frozen_string_literal: true

require 'json-schema'
class LocalAuthority::UseCase::ValidateReturn
  def initialize(return_template_gateway:)
    @return_template_gateway = return_template_gateway
  end

  def execute(type:, return_data:)
    schema = @return_template_gateway.find_by(type: type)
    valid = JSON::Validator.validate(schema.schema.to_json, return_data)
    invalid_paths = valid ? [] : get_paths_from_error_messages(schema, return_data)
    { valid: valid,
      invalid_paths: invalid_paths }
  end

  private

  def message_get_json_properties(message)
    ignore_json_property_root = %r{#/}
    capture_json_property = %r{([\w/]*)}
    ignore_until = /.*/
    message_parse_regex = /
      '
        #{ignore_json_property_root}
        #{capture_json_property}
      '
      #{ignore_until}
      '
        #{capture_json_property}
      '
    /x
    message.match(message_parse_regex)&.captures&.to_a&.reject(&:empty?)
  end

  def json_property_name_to_path(property)
    property.split('/').map do |node|
      begin
        Integer(node)
      rescue ArgumentError
        node.to_sym
      end
    end
  end

  def join_path_array(array_of_paths)
    array_of_paths.flatten
  end

  def json_properties_to_path(properties)
    json_paths = properties.map do |property|
      json_property_name_to_path(property)
    end
    join_path_array(json_paths)
  end

  def get_paths_from_error_messages(schema, return_data)
    validation_messages = JSON::Validator.fully_validate(
      schema.schema.to_json,
      return_data
    )

    validation_messages.map do |message|
      properties = message_get_json_properties(message)
      json_properties_to_path(properties) unless properties.nil?
    end.compact
  end
end
