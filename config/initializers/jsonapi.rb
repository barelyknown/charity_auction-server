JSONAPI.configure do |config|
  #:underscored_key, :camelized_key, :dasherized_key, or custom
  config.json_key_format = :dasherized_key

  #:underscored_route, :camelized_route, :dasherized_route, or custom
  config.route_format = :dasherized_route

  #:basic, :active_record, or custom
  config.operations_processor = :active_record

  #:integer, :uuid, :string, or custom (provide a proc)
  config.resource_key_type = :integer

  # optional request features
  config.allow_include = true
  config.allow_sort = true
  config.allow_filter = true

  # How to handle unsupported attributes and relationships which are provided in the request
  # true => raises an error
  # false => allows the request to continue. A warning is included in the response meta data indicating
  # the fields which were ignored. This is useful for client libraries which send extra parameters.
  config.raise_if_parameters_not_allowed = true

  # :none, :offset, :paged, or a custom paginator name
  config.default_paginator = :offset

  # Output pagination links at top level
  config.top_level_links_include_pagination = true

  config.default_page_size = 50
  config.maximum_page_size = 200

  # Output the record count in top level meta data for find operations
  config.top_level_meta_include_record_count = true
  config.top_level_meta_record_count_key = :record_count

  config.use_text_errors = false

  # List of classes that should not be rescued by the operations processor.
  # For example, if you use Pundit for authorization, you might
  # raise a Pundit::NotAuthorizedError at some point during operations
  # processing. If you want to use Rails' `rescue_from` macro to
  # catch this error and render a 403 status code, you should add
  # the `Pundit::NotAuthorizedError` to the `exception_class_whitelist`.
  # Subclasses of the whitelisted classes will also be whitelisted.
  config.exception_class_whitelist = []

  # Resource Linkage
  # Controls the serialization of resource linkage for non compound documents
  # NOTE: always_include_to_many_linkage_data is not currently implemented
  config.always_include_to_one_linkage_data = true
end
