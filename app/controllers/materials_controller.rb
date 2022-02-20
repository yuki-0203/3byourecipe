class MaterialsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :update, :destroy]
  def create; end

  def update; end

  def destroy; end
end
