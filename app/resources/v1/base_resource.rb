module V1
  class BaseResource < JSONAPI::Resource
    abstract

    class << self
      def creatable_fields(context)
        super - [:id]
      end
      alias_method :updatable_fields, :creatable_fields
    end

    def fetchable_fields
      super + [:created_at, :updated_at]
    end

  end
end
