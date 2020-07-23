class LinkSerializer < ActiveModel::Serializer
  attributes :id, :url, :shortened, :times_accessed
end
