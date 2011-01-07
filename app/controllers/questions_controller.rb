class GenericController < InheritedResources::Base
  actions :all
  has_scope :by_topic
  respond_to :html

  before_filter :authenticate_user!

  protected

    def begin_of_association_chain
      current_user
    end
end
