class DiscussAlternativesQuestion < FollowUpQuestion
  has_children_of_types [:Proposal,true],[:BackgroundInfo,true]
  has_linkable_types

  has_one :hub, :class_name => "CasHub", :foreign_key => "question_id"
  
  
  
  def transpose_mirror_tree
    alternatives = hub.children
    
    # create the new twin hub
    hub = CasHub.create(:root_id => question.target_id, :parent_id => question.target_id,
                        :statement => question.statement, :creator_id => question.creator_id)
      
    # create proposals that mirror the alternatives from the parent hub 
    alternatives.each do |alternative|
      attributes = alternative.attributes
      # delete attributes that we don't want to transpose
      attributes.delete("created_at")
      attributes.delete("updated_at")
      attributes.delete("lft")
      attributes.delete("rgt")
      attributes.delete("id")
      attributes.delete("type")
      attributes.delete("drafting_state")
      # add the id of the new twin hub as the parent_id
      attributes["parent_id"] = hub.id
      attributes["root_id"] = hub.root_id
      Proposal.create(attributes)
    end
  end

  class << self
    def new_instance(attributes = nil)
      # parent id that comes from the form is from an alternative, we have to delete it and add the new DAQ to the hub of the alternative
      parent_id = attributes ? attributes.delete(:parent_id) : nil
      new_daq = super
      new_daq.hub = StatementNode.find(parent_id).hub if parent_id
      new_daq
    end
    
    def is_mirror_discussion?
      true
    end
  end
end