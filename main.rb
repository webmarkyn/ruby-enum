# frozen_string_literal: true

module Enumerable
  def my_each
    return self unless block_given?

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
    temp = self if temp.empty?
    temp
  end

  def my_each_with_index
    return self unless block_given?

    (0..length - 1).each do |i|
      yield(self[i], i)
    end
  end

  def my_select
    return self unless block_given?

    temp = []
    (0..length - 1).each do |i|
      temp << self[i] if yield(self[i])
    end
    temp
  end

  def my_any?(param = true)
    each { |item| return true if yield(item) } if block_given?
    state = case param
            when Regexp then check_regexp(true, param)
            when Class then check_class(true, param)
            else check(true, param)
            end
    state == true ? state : false
  end

  def my_all?(param = true)
    each { |item| return false unless yield(item) } if block_given?
    state = case param
            when Regexp then check_regexp(false, param, true)
            when Class then check_class(false, param, true)
            else check(false, param, true)
            end
    state == false ? state : true
  end

  def my_none?(param = true)
    each { |item| return false if yield(item) } if block_given?
    state = case param
            when Regexp then check_regexp(false, param)
            when Class then check_class(false, param)
            else check(false, param)
            end
    state == false ? state : true
  end

  def check_regexp(status, param, negative = false)
    each { |item| return status unless param.match(item) } if negative
    each { |item| return status if param.match(item) } unless negative
  end

  def check_class(status, param, negative = false)
    each { |item| return status unless item.instance_of? param } if negative
    each { |item| return status if item.instance_of? param } unless negative
  end

  def check(status, param, negative = false)
    each { |item| return status unless item == param } if negative
    each { |item| return status if item == param } unless negative
  end

  def my_count(cond = nil)
    counter = 0
    each do |item|
      counter += 1 if (block_given? && yield(item)) || (item == cond) || (!cond && !block_given?)
    end
    counter
  end

  def my_inject(*args)
    acc = setup_acc(args)
    return multiply_els(self) if args.include? :*

    return add_els(self) if args.include? :+

    return divide_els(self) if args.include? :/

    return subs_els(self) if args.include? :-

    each { |item| acc = yield(acc, item) }
    acc
  end

  def setup_acc(param)
    !param[0].is_a?(Symbol) && !param.empty? ? param[0] : 0
  end

  def multiply_els(arr)
    arr.my_inject(1) { |acc, item| acc * item }
  end

  def add_els(arr)
    arr.my_inject(0) { |acc, item| acc + item }
  end

  def divide_els(arr)
    arr.my_inject(1.0) { |acc, item| acc / item }
  end

  def subs_els(arr)
    arr.my_inject(0) { |acc, item| acc - item }
  end
end

# puts [1,2,3].my_all?{ |item| item<0}
# puts %w[s str string].my_none?(/g/)
# puts [1,2,3].my_none?{ |item| item<0}
# puts [false, false, false].my_none?

# puts [1,2,2].my_map { |item| item+2}

# puts([1, 2, 2].my_count(1))

# puts multiply_els([3, 2, 3])

# puts([1, 2, 3].my_inject(0) { |acc, item| acc + item })

# mr = proc { |item| item + 2 }

# puts([1, 2, 3].my_map(&mr))
# puts([1, 2, 3].my_map { |item| item + 2 })

# [1,2,3,4].my_each_with_index{ |item, index| puts index}
# puts [1,2,3,4].my_select{ |item| item.even?}
# [1,2,3].my_each { |item| puts item }

# puts [3,2,3].my_inject(2) { |acc, item| acc+item}

# class Foo
#
# end
#
# puts Foo.is_a? Class
#
# puts /yey/.is_a? Regexp
