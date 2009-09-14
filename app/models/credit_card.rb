
class CreditCard < ActiveRecord::BaseWithoutTable
  
  # payment detail validation
  validates_length_of :card_name, :in => 2..50
  validates_length_of :card_number, :in => 13..19, :on => :create 
  # linkpoint should be able to determine card type
  #validates_inclusion_of :card_type, :in => ['visa', 'master', 'discover', 'american_express'], :on => :create 
  validates_inclusion_of :card_expiration_month, :in => %w(1 2 3 4 5 6 7 8 9 10 11 12), :on => :create 
  validates_inclusion_of :card_expiration_year, 
                        :in => %w(2007 2008 2009 2010 2011 2012 2013 2014 2015), :on => :create 
  validates_length_of :card_security_code, :in => 3..4, :on => :create
  
  #card accessors
  attr_accessor :card_name, :card_number, :card_type, :card_security_code, 
                :card_expiration_month, :card_expiration_year
              
protected

   def luhn_check? num
     odd = true
     num.to_s.gsub(/\D/,'').reverse.split('').map(&:to_i).collect { |d|
        d *= 2 if odd = !odd
        d > 9 ? d - 9 : d
     }.sum % 10 == 0
   end  
                
   def validate
     # these validations cause problems in the unit test if they
     # are not wrapped in a null check, rspec?

     # billing info
    #   if !full_name.nil?
    #     errors.add(:full_name, "must contain a first and last name.") if ! full_name.include? ' '
    #   end

     if !card_name.nil?
       errors.add(:card_name, "must contain a first and last name.") if ! card_name.include? ' '
     end

     if ! luhn_check? card_number
       errors.add(:card_number, "is not a valid credit card number.")
     end

   end
  
  
end