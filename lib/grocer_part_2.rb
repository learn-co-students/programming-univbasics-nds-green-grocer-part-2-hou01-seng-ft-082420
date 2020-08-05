require_relative './part_1_solution.rb'

def apply_coupons(cart, coupons)
  new_coupon = []
  coupons.map do |coupon|
    cart.map do |item_lookup|
      if item_lookup[:item] === coupon[:item] && item_lookup[:count] >= coupon[:num]
        item_lookup[:count] -= coupon[:num]
        item_price = coupon[:cost] / coupon[:num]
        cart.push({item: "#{coupon[:item]} W/COUPON", price: item_price, clearance: item_lookup[:clearance], count: coupon[:num]})
      end #if 
    end #cart.map 
  end #coupons.map
  cart 
end #method

def apply_clearance(cart)
  cart.map do |items|
    if items[:clearance]
      items[:price] = (items[:price]*0.8).round(2)
    end #if items
  end #cart.map 
  cart 
end


def checkout(cart, coupons)
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
  total = 0
  cart.each{|item| total += (item[:price]*item[:count])}
  total > 100 ? total *= 0.9 : total
  total
end

