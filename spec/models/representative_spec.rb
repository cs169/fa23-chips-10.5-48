# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'

describe Representative do
  describe 'searching for representative' do
    before do
      @rep_info = OpenStruct.new(
        officials: [
          OpenStruct.new(name: 'John Doe', title: 'Representative'),
          OpenStruct.new(name: 'Jane Smith', title: 'Senator')
        ],
        offices:   [
          OpenStruct.new(name: 'House of Representatives', division_id: 'ocdid1', official_indices: [0]),
          OpenStruct.new(name: 'Senate', division_id: 'ocdid2', official_indices: [1])
        ]
      )
    end

    it 'not in the database' do
      described_class.civic_api_to_representative_params(@rep_info)
      expect(described_class.count).to eq(2)
    end

    it 'in the database' do
      described_class.create!({ name:  'John Doe', ocdid:  'ocdid1',
      title: 'Representative' })
      described_class.civic_api_to_representative_params(@rep_info)
      expect(described_class.count).to eq(2)
    end
  end
end
