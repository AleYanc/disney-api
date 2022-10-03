class GenresSerializer
  include JSONAPI::Serializer
  attributes :name, :image
end