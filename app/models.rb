class Event
  include Mongoid::Document

  field :title,       type: String
  field :url,         type: String
  field :description, type: String
  field :starts_at,   type: DateTime
  field :ends_at,     type: DateTime
  field :location,    type: String
  field :verified,    type: Boolean, default: true # FIXME

  validates_presence_of :title, :url, :starts_at

  default_scope order_by(starts_at: :asc)
end
