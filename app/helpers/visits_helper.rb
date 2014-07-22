module VisitsHelper
  def total_duration visits
    Time.at(visits.map{ |visit| visit.duration }.reduce(:+)).utc.strftime("%H:%M:%S").gsub(/^[0:]*/, '')
  end

  def pie_chart_data visits
    visits.map{|visit| visit.to_pie_chart_json}
  end

  def step_graph_format time
    time.to_i * 1000
  end

  def step_graph_data visits
    x_axis = visits.flat_map { |visit| [step_graph_format(visit.enter_time), step_graph_format(visit.exit_time)] }
    y_axis = visits.flat_map { |visit| [visit.product_area.id, visit.product_area.id] }
    x_axis.zip(y_axis)
  end

  def step_graph_labels visits
    visits.map{ |visit| [visit.product_area.id, visit.product_area.name] }.uniq
  end

  def unique_areas visits
    visits.map{ |visit| visit.product_area }.uniq
  end

  def coupons_map
    {
        'Yogurt' => {name: 'Chobani', description: '$1.00 Off'},
        'Condiments and sauces' => {name: 'Campbell\'s', description: '$0.50 Off'},
        'Salad dressings and mayonnaise' => {name: 'Wish-bone', description: 'BOGO Free'},
        'Pet food and pet products' => {name: 'Friskies', description: 'BOGO 50% Off'},
        'Crackers, cookies and bread' => {name: 'Nabisco', description: '$1.50 Off'}
    }
  end

  def coupons_image_map
    {
        'Yogurt' => 'chobani.jpg',
        'Condiments and sauces' => 'campbells.jpg',
        'Salad dressings and mayonnaise' => 'wishbone.jpg',
        'Pet food and pet products' => 'friskies.jpg',
        'Crackers, cookies and bread' => 'nabisco.jpg'
    }
  end

  def coupon_event(coupon_name, clicked_coupons)
    clicked_coupons.map(&:name).include?(coupon_name) ? 'clicked' : 'delivered'
  end
end
