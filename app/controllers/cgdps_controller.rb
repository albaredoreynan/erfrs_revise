class CgdpsController < ApplicationController

  %w[id user year status].each{ |e| has_scope "with_#{e}".intern }
  %w[region province municipality].each{ |e| has_scope "subproject_#{e}_id".intern }

  def index
    @subprojects = apply_scopes(Subproject).includes(:region, :province, :municipality).group_by(&:municipality)
  end

end
