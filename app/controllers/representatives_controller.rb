# frozen_string_literal: true

class RepresentativesController < ApplicationController
  def index
    @representatives = Representative.all
  end

  def show
    @representative = Representative.find(params[:id])
    @additional_info = fetch_representative_details(@representative)
    service = Google::Apis::CivicinfoV2::CivicInfoService.new
    service.key = Rails.application.credentials[:GOOGLE_API_KEY]
    result = service.representative_info_by_address(address: address)
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
