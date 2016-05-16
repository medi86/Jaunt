class Jaunt < ActiveRecord::Base
  has_many :locations
  belongs_to :user

  include Tire::Model::Search
  include Tire::Model::Callbacks

  def self.search(params)
    tire.search(load: true) do
      query { string params[:query] } if params[:query].present?
    end
  end
end
