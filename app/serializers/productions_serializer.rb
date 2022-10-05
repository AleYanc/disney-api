class ProductionsSerializer
  include JSONAPI::Serializer
  attributes :title, :image

  attributes :score, :released_date, if: Proc.new { |record, params|
    !params[:context][:index]
  }
end