class BubblesController < ApplicationController
  before_action :set_bubble, only: %i[ show edit update ]

  def index
    if params[:tag_id]
      @tag = Tag.find(params[:tag_id])
      @bubbles = @tag.bubbles
    else
      @bubbles = Bubble.all
    end
  end

  def new
    @bubble = Bubble.new
  end

  def edit
  end

  def update
    @bubble.update(bubble_params)
    remove_image if params[:remove_image] == "true"

    redirect_to bubble_path(@bubble)
  end

  def create
    Bubble.create! bubble_params

    redirect_to bubbles_path
  end

  def show
  end

  private
    def set_bubble
      @bubble = Bubble.find(params[:id])
    end

    def bubble_params
      params.require(:bubble).permit(:title, :body, :color, :image, :remove_image, tag_ids: [])
    end

    def remove_image
      @bubble.image.purge
    end
end
