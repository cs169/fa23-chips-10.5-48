# frozen_string_literal: true

require 'open-uri'
require 'json'

class MyNewsItemsController < SessionController
  before_action :set_representative
  before_action :set_representatives_list
  before_action :set_issue_list
  before_action :set_news_item, only: %i[edit update destroy]

  def new
    @news_item = NewsItem.new
  end

  def edit; end

  def create
    @news_item = NewsItem.new(news_item_params)
    if @news_item.save
      redirect_to representative_news_item_path(@representative, @news_item),
                  notice: 'News item was successfully created.'
    else
      render :new, error: 'An error occurred when creating the news item.'
    end
  end

  def update
    if @news_item.update(news_item_params)
      redirect_to representative_news_item_path(@representative, @news_item),
                  notice: 'News item was successfully updated.'
    else
      render :edit, error: 'An error occurred when updating the news item.'
    end
  end

  def destroy
    @news_item.destroy
    redirect_to representative_news_items_path(@representative),
                notice: 'News was successfully destroyed.'
  end

  def search
    set_representative
    set_issue
    set_articles
    render :search
  end

  def add_article
    # render :new
    article = params['article']
    # json = JSON.parse(article)
    JSON.parse article.gsub('=>', ':')
    json = JSON.parse article.gsub('=>', ':')
    @news_item = NewsItem.new({ title: json['title'], description: json['description'], link: json['url'],
representative_id: params[:representative_id], issue: params[:issue] })
    if @news_item.save
      redirect_to representative_news_item_path(@representative, @news_item),
                  notice: 'News item was successfully created.'
    else
      render :new, error: 'An error occurred when creating the news item.'
    end
  end

  private

  def set_representative
    @representative = Representative.find(
      params[:representative_id]
    )
  end

  def set_issue
    @issue = params[:news_item][:issue]
  end

  def set_articles
    url = 'https://newsapi.org/v2/everything?'\
          "q=+#{@representative.name}%20+#{@issue}&"\
          "apiKey=#{Rails.application.credentials[:NEWS_API_KEY]}"

    req = URI.parse(url).open

    response_body = req.read
    json = JSON.parse(response_body)

    @articles = json['articles'].take(5)
    # newsapi = News.new(Rails.application.credentials[:NEWS_API_KEY])
    # @articles = newsapi.get_top_headlines(q: "Joe Biden").articles
  end

  def set_representatives_list
    @representatives_list = Representative.all.map { |r| [r.name, r.id] }
  end

  def set_issue_list
    @issue_list = ['Free Speech', 'Immigration', 'Terrorism', "Social Security and
    Medicare", 'Abortion', 'Student Loans', 'Gun Control', 'Unemployment',
                   'Climate Change', 'Homelessness', 'Racism', 'Tax Reform', "Net
    Neutrality", 'Religious Freedom', 'Border Security', 'Minimum Wage',
                   'Equal Pay']
  end

  def set_news_item
    @news_item = NewsItem.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def news_item_params
    params.require(:news_item).permit(:news, :title, :description, :link, :representative_id, :issue)
  end
end
