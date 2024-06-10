class TreesController < ApplicationController

  def index
    @trees = Tree.order(updated_at: :desc)
  end

  def show
    @tree = Tree.find_by(id: params[:id])
    @item_descriptions = @tree.item_descriptions.order(id: :asc)
  rescue Exception
    render file: "#{Rails.root}/public/404.html", layout: false, status: 404
  end
end