require 'spec_helper'

describe VisitsController do
  describe '#create' do
    context 'with json request' do
      before :each do
        @sometime = DateTime.parse('Mon, 03 Feb 2014 18:13:50 UTC +00:00')
        @sometime_later = DateTime.parse('Mon, 03 Feb 2014 18:13:50 UTC +00:00') + 2.hours
        @request_data = {
          membership_number: 12345,
          visit: {
            product_area: 'Wine Cellar',
            enter_time: @sometime.to_s,
            exit_time: @sometime_later.to_s
          }
        }
      end

      it 'creates a new visit, a new customer, and a new product area' do
        post :create, @request_data, use_route: :visits_new

        customer = Customer.find_by(membership_number: 12345)
        customer.should_not be_nil
        customer.visits.where(enter_time: @sometime, exit_time: @sometime_later).should exist
        ProductArea.find_by(name: 'Wine Cellar').should_not be_nil
      end

      it 'creates a second visit, using an existing customer, and an existing product area' do
        FactoryGirl.create(:dairy_visit)

        post :create, @request_data, use_route: :visits_new

        Customer.find_by(membership_number: 12345).visits.where(enter_time: @sometime, exit_time: @sometime_later).should exist
        ProductArea.find_by(name: 'Wine Cellar').should_not be_nil
      end
    end
  end
end