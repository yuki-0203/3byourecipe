class MaterialsController < ApplicationController
  before_action :authenticate_user!, only: %i[create update destroy]
  def create; end

  def update; end

  def destroy; end
end
