require_relative './part_1_solution.rb'
require 'pry'

def apply_coupons(cart, coupons)
  i = 0 
  while i < coupons.length 
  cart_item = find_item_by_name_in_collection(coupons[i][:item], cart)
  couponed_item_name = "#{coupons[i][:item]} W/COUPON"
  cart_item_with_coupon = find_item_by_name_in_collection(couponed_item_name, cart)
  if cart_item && cart_item[:count] >= coupons[i][:num]
    if cart_item_with_coupon
      cart_item_with_coupon[:count] += coupons[i][:num]
      cart_item[:count] -= coupons[i][:num]
    else 
      cart_item_with_coupon = {
        :item => couponed_item_name,
        :price => coupons[i][:cost] / coupons[i][:num],
        :count =>   coupons[i][:num],
        :clearance => cart_item[:clearance]
      }
      cart << cart_item_with_coupon
      cart_item[:count] -= coupons[i][:num]
    end
  end
  i += 1 
  end
  cart
end

def apply_clearance(cart)
  new_cart = []
  i = 0  
  while i < cart.length
  new_cart << cart[i]
  if new_cart[i][:clearance]
    new_cart[i][:price] -= new_cart[i][:price]*(0.2)
    new_cart[i][:price].round
  end
  i += 1   
  end
  new_cart
end

def checkout(cart, coupons)

  consolidated_cart = consolidate_cart(cart)
  couponed_cart = apply_coupons(consolidated_cart, coupons)
  clearanced_cart = apply_clearance(cart)
  i = 0 
  while i < clearanced_cart.length
  grand_total = grand_total + (clearanced_cart)[i][:price] * clearanced_cart[i][:count])
  i += 1
  end
  if grand_total > 100 
    grand_total = grand_total - (grand_total*(0.1))
    grand_total.round 
  end
  
  grand_total
  
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
end
