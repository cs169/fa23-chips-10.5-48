# frozen_string_literal: true

class RepresentativesController < ApplicationController
  def index
    @representatives = Representative.all
  end

  def show
    @representative = Representative.find(params[:id])
    @additional_info = fetch_representative_details(@representative)
  end
  
  private
  
  def fetch_representative_details(representative)
    # Use Google Civic Information API or any other service to get detailed information
    # You may need to handle authentication, API requests, and parsing the response
    # Example:
    # api_response = YourService.get_representative_details(representative.name)
    # Parse the response and return necessary details
  end
  
end
