class BaseSerializer
  include FastJsonapi::ObjectSerializer

  def to_json(_arg)
    Oj.dump(serializable_hash, mode: :compat)
  end

  alias_method :serialized_json, :to_json
end
