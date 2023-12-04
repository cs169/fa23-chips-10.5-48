# frozen_string_literal: true

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

  private

  def set_representative
    @representative = Representative.find(
      params[:representative_id]
    )
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

  def save_rating
    # Retrieve the selected article ID and rating from the form
    selected_article_id = params[:selected_article_id]
    rating = params[:rating]
  
    # Find the article based on the selected ID
    selected_article = @news_articles.find { |article| article[:id] == selected_article_id }
  
    if selected_article
      # Save the article and rating to the database (assuming you have a NewsItem model)
      NewsItem.create!(
        title: selected_article[:title],
        link: selected_article[:url],
        description: selected_article[:description],
        rating: rating
      )
      flash[:success] = 'Article and rating saved successfully!'
      redirect_to root_path # Redirect wherever you need
    else
      flash[:error] = 'Selected article not found!'
      render :select_article # Render the article selection page again with an error message
    end
  end

  # Only allow a list of trusted parameters through.
  def news_item_params
    params.require(:news_item).permit(:news, :title, :description, :link, :representative_id, :issue)
  end
end
