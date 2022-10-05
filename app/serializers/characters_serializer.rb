class CharactersSerializer
  include JSONAPI::Serializer
  attributes :name, :age, :weight, :history, :image

  attribute :name
  attribute :image

  attributes :age, :weight, :history, :productions, if: Proc.new { |record, params|
    !params[:context][:index]
  }
end