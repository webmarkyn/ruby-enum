# frozen_string_literal: true

module Enumerable
  def my_each
    (0..length - 1).each do |i|
      yield(self[i])
    end
  end

  def my_map(&proc)
    temp = []
    (0..length - 1).each do |i|
      temp << [proc.call(self[i])] if proc
      temp << yield(self[i]) if block_given? && !proc
    end
    temp
  end

  def my_each_with_index
    (0..length - 1).each do |i|
      yield(self[i], i)
    end
  end

  def my_select
    temp = []
    (0..length - 1).each do |i|
      temp << self[i] if yield(self[i])
    end
    temp
  end

  def my_any?
    each do |item|
      return true if block_given? && yield(item)
      return true if item && !block_given?
    end
    false
  end

  def my_all?
    each do |item|
      if block_given?
        return false unless yield(item)
      else return false unless item
      end
    end
    true
  end

  def my_none?(condition = false)
    each do |item|
      if block_given?
        return false if yield(item)
      elsif item == condition then return false
      end
    end
    true
  end

  def my_count(cond = true)
    counter = 0
    each do |item|
      if block_given? && yield(item)
        counter += 1
      elsif item == cond
        counter += 1
      end
    end
    counter
  end

  def my_inject(acc = 0)
    each do |item|
      acc = yield(acc, item)
    end
    acc
  end
end

def multiply_els(arr)
  arr.my_inject(1) { |acc, item| acc * item }
end

# puts [1,2,3].my_all?{ |item| item<0}
# puts [1,2,3].my_any?{ |item| item<1}
# puts [1,2,3].my_none?{ |item| item==3}

# puts([1, 2, 2].my_count { |item| item==2 })

# puts multiply_els([3, 2, 3])

# puts([1, 2, 3].my_inject(0) { |acc, item| acc + item })

# mr = proc { |item| item + 2 }

# puts([1, 2, 3].my_map(&mr))
# puts([1, 2, 3].my_map { |item| item + 2 })

# [1,2,3,4].my_each_with_index{ |item, index| puts index}
# puts [1,2,3,4].my_select{ |item| item.even?}
# [1,2,3].my_each { |item| puts item }
