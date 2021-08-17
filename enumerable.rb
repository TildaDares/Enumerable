module Enumerable
  def my_each
      for el in self
        yield el
      end
  end

  def my_each_with_index
    i = 0
    my_each do |el|
      yield el, i
      i += 1
    end
  end

  def my_select
    result = is_a?(Hash) ? {} : []
    my_each do |el|
      if yield el
        is_a?(Hash) ? result[el[0]] = el[1] : result << el
      end
    end

    result
  end

  def my_all?
    my_each do |elem|
      return false unless yield elem
    end

    true
  end

  def my_any?
    my_each do |elem|
      return true if yield elem
    end

    false
  end

  def my_none?
    my_each do |elem|
      return false if yield elem
    end

    true
  end

  def my_count
    count = 0
    if block_given?
      my_each do |elem|
        count += 1 if yield elem
      end
    else
      my_each do |elem|
        count += 1
      end
    end
    
    count
  end

  def my_map(proc = nil)
    result = []
    my_each do |elem|
      result << (proc ? proc.call(elem) : yield(elem))
    end

    result
  end

  def my_inject(start = nil)
    acc = start ? start : self[0]
    my_each do |elem|
      acc = yield acc, elem
    end
  end
end
numbers = [1, 2, 3, 4, 5]
# numbers.my_each  { |item| puts item }
# numbers.my_each_with_index  { |item, index| puts "#{item} #{index}" }
# p numbers.my_select(&:even?)
# p numbers.my_all? { |item| item > 0 }
# p numbers.my_any? { |item| item > 6 }
# p numbers.my_none?(&:even?)
# p numbers.count {|element| element > 1}
# p numbers.my_map(&:to_s)
my_proc = proc {|x| x >= 4}
arr = [1,2,3,4,5]
hash = {:a=>1, :b=>2, :c=>3, :d=>4, :e=>5}
bar = "--------------------------"

arr.my_each_with_index {|x, i| puts i}
puts bar
puts arr.my_select {|n| n.even?}
puts bar
puts arr.my_all? {|n| n % 6 == n}
puts bar
puts arr.my_any? {|n| n % 6 == n}
puts bar
puts arr.my_none? {|n| n % 6 == n}
puts bar
puts arr.my_count {|n| n % 6 == n}
puts bar
puts arr.my_map {|n| n < 4}
puts bar
puts arr.my_map(&my_proc)
puts bar
puts arr.my_inject {|sum, number| sum + number}
puts bar
puts arr.my_inject {|sum, number| sum * number}