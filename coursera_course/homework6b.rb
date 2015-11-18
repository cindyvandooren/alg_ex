require 'byebug'
require 'io/console'
require 'rubygems'
require 'algorithms'

include Containers

# Course Link: https://class.coursera.org/algo-009/quiz/attempt?quiz_id=253

# Question 2
# Download the text file here.

# The goal of this problem is to implement the "Median Maintenance" algorithm 
# (covered in the Week 5 lecture on heap applications). The text file contains 
# a list of the integers from 1 to 10000 in unsorted order; you should treat 
# this as a stream of numbers, arriving one by one. Letting xi denote the ith 
# number of the file, the kth median mk is defined as the median of the numbers 
# x1,…,xk. (So, if k is odd, then mk is ((k+1)/2)th smallest number among x1,…,xk; 
# 	if k is even, then mk is the (k/2)th smallest number among x1,…,xk.)

# In the box below you should type the sum of these 10000 medians, modulo 10000 
# (i.e., only the last 4 digits). That is, you should compute (m1+m2+m3+⋯+m10000)
# mod10000.

# OPTIONAL EXERCISE: Compare the performance achieved by heap-based and 
# search-tree-based implementations of the algorithm.


# This application uses MinHeap and MaxHeap as implemented in the Ruby algorithms
# gem. Docs: https://github.com/kanwei/algorithms/blob/master/lib/containers/heap.rb
def sum_medians(file)
	low_heap = MaxHeap.new
	high_heap = MinHeap.new
	current_median = 0
	sum = 0

	File.open(file).each_line do |line|
		num = line.to_i

		# Add number to one of the heaps.
		if low_heap.empty? && high_heap.empty?
			low_heap.push(num)
		elsif num > low_heap.max 
			high_heap << num
		else
			low_heap << num
		end

		# Now check if the two heaps are not too different in size (difference can be 
		# at most 1) and rebalance if necessary.
		if low_heap.size > high_heap.size + 1
			high_heap << low_heap.max!
		elsif high_heap.size > low_heap.size + 1
			low_heap << high_heap.min!
		end

		# Update current_median and the sum.
		if low_heap.empty? || high_heap.empty?
			current_median = num
		elsif low_heap.size == high_heap.size
			current_median = low_heap.max
		elsif low_heap.size > high_heap.size
			current_median = low_heap.max
		else
			current_median = high_heap.min
		end		

		sum += current_median
	end

	return sum % 10000
end

if $PROGRAM_NAME == __FILE__
	file = ARGV.empty? ? "numbers6b.txt" : ARGV[0]
	p sum_medians(file)
end