class SchemaImplementation
  def initialize
    @query = Resolvers::Query.new
  end

  def call(type, field, obj, args, ctx)
    obj = to_resolver(obj)
    field_name = field.name.underscore

    result = case type.graphql_name
             when "Query"
               resolve_query(field_name, args, ctx)
             else
               resolve_field(field_name, obj, args, ctx)
             end

    result

    # if field.connection?
    #   to_connection(result, args, ctx)
    # else
    #   result
    # end
  end

  private

  def to_connection(result, args, ctx)
    connection_class = ctx.schema.connections.wrapper_for(result)

    if connection_class.nil?
      raise StandardError "Didn't know how to wrap #{result.class} into connection"
    end

    constructor_args = args.merge({ context: ctx })
    connection_class.new(result, **constructor_args)
  end

  def to_resolver(obj)
    # crude workaround for example's sake.
    if obj.is_a?(Author)
      Resolvers::Author.new(obj)
    else
      obj
    end
  end

  def resolve_query(query_name, args, ctx)
    resolve_method(query_name, @query, args, ctx).call(@query, args, ctx)
  end

  def resolve_field(field_name, obj, args, ctx)
    resolve_method(field_name, obj, args, ctx).call(obj, args, ctx)
  end

  def resolve_method(method_name, obj, _args, _ctx)
    binding.pry if obj.nil?
    method_arity = obj.method(method_name).arity

    case method_arity
    when 0, -1
      ->(o, _a, _c) { o.public_send(method_name) }
    when 1
      ->(o, a, _c) { o.public_send(method_name, **a) }
    when 2
      ->(o, a, c) { o.public_send(method_name, a, c) }
    else
      raise "Unexpected method arity: #{method_arity}."
    end
  end
end
