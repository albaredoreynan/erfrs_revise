class RegionalOfficersController < ApplicationController
	require 'will_paginate/array'
  
  respond_to :html, :json
  
  has_scope :region_id
  before_filter :subheader
  #has_scope :ro_type

  def index
    @regional_officers = apply_scopes(RegionalOfficer).all.paginate(page: params[:page], per_page: 30)
  end

  def new
  	@regional_officer = RegionalOfficer.new
  end

  def edit
  	@regional_officer = RegionalOfficer.find(params[:id])
  end

  def create
  	@regional_officer = RegionalOfficer.new(regional_officer_params)
  	if @regional_officer.save
      flash[:success] = 'Regional Officer was successfully created.'
      redirect_to regional_officers_path
    else
      flash[:error] = 'An error occured while creating new officer.'
      render 'new'
    end
  end

  def update
  	@regional_officer = RegionalOfficer.find params[:id]
    if @regional_officer.update_attributes regional_officer_params
      flash[:success] = 'Regional Officer updated successfully.'
      redirect_to regional_officers_path
    else
      flash[:error] = 'An error occured while updating the officer'
      render 'edit'
    end
  end

  def destroy
    @regional_officer = RegionalOfficer.find(params[:id])
    @regional_officer.destroy!
    flash[:success] = 'Regional Officer has been remove.' 
    redirect_to regional_officers_path
  end

  def subheader
    @hide_nav = true
  end
	
	private
		def regional_officer_params
		  params.require(:regional_officer).permit(:name, :designation, :ro_type, :region_id, :box)
		end
end