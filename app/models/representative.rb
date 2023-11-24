# frozen_string_literal: true

class Representative < ApplicationRecord
  has_many :news_items, dependent: :delete_all

  def self.civic_api_to_representative_params(rep_info)
    reps = []

    rep_info.officials.each_with_index do |official, index|
      ocdid_temp = ''
      title_temp = ''
      address_temp = ''
      pol_party_temp = ''
      photo_temp = ''

      rep_info.offices.each do |office|
        if office.official_indices.include? index
          title_temp = office.name
          ocdid_temp = office.division_id
        end
      end

      rep_info.officials.each do |person|
        adress_temp = person.address
        pol_party_temp = person.party
        photo_temp = person.photoUrl
      end

      # Can we make it so that when we create this representative, we also add in other information.  
      # This would probably be the easiest way to gather all the rep's information all in one method. 
      # For example:
      
      rep = Representative.create!({ name: official.name, ocdid: ocdid_temp,
      title: title_temp,  address: adress_temp, polparty: pol_party_temp, photoUrl: photo_temp})

      # rep = Representative.create!({ name: official.name, ocdid: ocdid_temp,
      #     title: title_temp })

      
      reps.push(rep)
    end

    reps
  end
end
