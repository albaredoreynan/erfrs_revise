require 'spec_helper'

describe Subproject do
  context "VALIDATION" do
    let(:empty_subproject) { Subproject.create }

    describe 'present attirbutes' do
      %i(region_id municipality_id province_id barangay_id title cycle).each do |attr|
        it { expect(empty_subproject.errors.messages[attr].first).to eq("can't be blank")}
      end
    end

    describe "#total_tranch_must_equal_to_grant_amount validation" do
    end

  end
end
