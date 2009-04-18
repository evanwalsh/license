#!/usr/bin/ruby

class License
  require "rubygems"
  require "digest/sha1"
  EXTRA = "evnwlsh"
  attr_reader :name,:email,:product
  
  def initialize(name,email,product)
    @name = name
    @email = email
    @product = product
  end

  def encrypt(str)
    encrypted = Digest::SHA1.hexdigest("#{str}#{EXTRA}")
    return encrypted.slice!(0..3).upcase
  end
  
  def generate
    name = @name.split
    key0 = encrypt(@product)
    key1 = encrypt(name[0])
    key2 = encrypt(name[1])
    key3 = encrypt(@email)
    
    return "#{key0}-#{key1}-#{key2}-#{key3}"
  end
  
  def check(keys)
    valid = String.new
    keys.each do |original,encrypted|
      if encrypt(original).eql? encrypted
        if !valid
          valid = false
        end
        if valid.empty?
          valid = "valid"
        end
      else
        valid = false
      end
    end
    valid
  end
  
  def validate(key)
    key = key.split("-")
    name = @name.split
    keys = Hash.new
    keys[@product] = key[0]
    keys[name[0]] = key[1]
    keys[name[1]] = key[2]
    keys[@email] = key[3]
    if check(keys)
      true
    end
  end
end