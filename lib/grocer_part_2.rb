require_relative './part_1_solution.rb'
require 'pry'

def apply_coupons(cart, coupons)
  cart.each do |grocery_item|
    coupons.each do |coupon|
      if coupon[:item] == grocery_item[:item]
        until grocery_item[:count] < coupon[:num]
          cart.append({item: grocery_item[:item] + " W/COUPON", 
                       price: coupon[:cost] / coupon[:num],
                       clearance: grocery_item[:clearance],
                       count: coupon[:num]
                      })
          grocery_item[:count] = grocery_item[:count] - coupon[:num]
        end 
      end 
    end 
  end 
end


def apply_clearance(cart)
  cart.each do |grocery_item|
    if grocery_item[:clearance] == true 
      grocery_item[:price] = grocery_item[:price] - (grocery_item[:price] * 0.20)
    end 
  end 
end


def checkout(cart, coupons)
  
  consolidated_cart = consolidate_cart(cart)
  coupon_applied_cart = apply_coupons(consolidated_cart,coupons)
  final_cart = apply_clearance(coupon_applied_cart)
  total_cost = 0 
  final_cart.each do |grocery_item|
    total_cost += (grocery_item[:count] * grocery_item[:price])
  end 
  if total_cost > 100
    total_cost = total_cost - (total_cost*0.10)
  end 
  total_cost

end
