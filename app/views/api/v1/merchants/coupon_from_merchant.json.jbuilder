json.code 200
json.message "Coupon fetch fetched successfully"
json.coupons @coupons, partial: 'api/v1/merchants/coupons', as: :coupon