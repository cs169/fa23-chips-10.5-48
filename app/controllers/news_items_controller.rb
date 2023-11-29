# frozen_string_literal: true

class NewsItemsController < ApplicationController
  before_action :set_representative
  before_action :set_news_item, only: %i[show]

  def index
    @representative = Representative.find(params[:representative_id])
    @news_items = @representative.news_items
    @news_items = fetch_top_articles(@representative.id)
  end

  def show; end

  private

  def fetch_articles(representative_id)
    service = Google::Apis::CivicinfoV2::CivicInfoService.new
    service.key = Rails.application.credentials[:NEWS_API_KEY]
    result = service.representative_info_by_address(address: address)
    @representatives = Representative.civic_api_to_representative_params(result)
    render 'representatives/search'

  end
    

  def set_representative
    @representative = Representative.find(
      params[:representative_id]
    )
  end

  def set_news_item
    @news_item = NewsItem.find(params[:id])
  end
end
