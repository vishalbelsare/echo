class DiscussController < ApplicationController
  
  auto_complete_for :tag, :value, :limit => 5 do |tags|
    content = tags.map{ |tag|
      pre = %w(* #)
      !pre.select{|p| tag.value.index(p) == 0}.empty? ? nil : "#{tag.value}|#{tag.id}"
    }.compact.join("\n")
   end
  
  # GET /discuss
  def roadmap
    respond_to do |format|
      format.html
    end
  end
  
  def index
    respond_to do |format|
      format.html
    end
  end
    
  # processes a cancel request, and redirects back to the last shown statement_node
  def cancel
    @statement_node = StatementNode.find(session[:last_statement_node])
    case @statement_node.class.name
    when "Question"
      redirect_to question_url(@statement_node)
    when "Proposal"
      redirect_to question_proposal_path(@statement_node.parent, @statement_node)
    when "ImprovementProposal"
      redirect_to question_proposal_improvement_proposal_url(@statement_node.root, @statement_node.parent, @statement_node)
    end
  end

end
