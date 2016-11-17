module Staffs::Reports::CustomersHelper
  def full_address(fullfillment_shpping_addr_obj)
    fullfillment_shpping_addr_obj.address +
      fullfillment_shpping_addr_obj.district +
      fullfillment_shpping_addr_obj.state +
      fullfillment_shpping_addr_obj.postal_code
  end
end
