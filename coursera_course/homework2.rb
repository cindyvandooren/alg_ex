require "byebug"
require "io/console"

# Link to course: https://class.coursera.org/algo-009/quiz/attempt?quiz_id=33

# Question 1
# GENERAL DIRECTIONS:
# Download the text file here. 

# The file contains all of the integers between 1 and 10,000 (inclusive, with no repeats) 
# in unsorted order. The integer in the ith row of the file gives you the ith entry of an 
# input array.

# Your task is to compute the total number of comparisons used to sort the given input file 
# by QuickSort. As you know, the number of comparisons depends on which elements are chosen as 
# pivots, so we'll ask you to explore three different pivoting rules.
# You should not count comparisons one-by-one. Rather, when there is a recursive call on a 
# subarray of length m, you should simply add m−1 to your running total of comparisons. 
# (This is because the pivot element is compared to each of the other m−1 elements in the subarray 
# in this recursive call.)

# WARNING: The Partition subroutine can be implemented in several different ways, and different 
# implementations can give you differing numbers of comparisons. For this problem, you should 
# implement the Partition subroutine exactly as it is described in the video lectures (otherwise 
# you might get the wrong answer).

# DIRECTIONS FOR THIS PROBLEM:

# For the first part of the programming assignment, you should always use the first element of 
# the array as the pivot element.

# HOW TO GIVE US YOUR ANSWER:

# Type the numeric answer in the space provided.
# So if your answer is 1198233847, then just type 1198233847 in the space provided without any 
# space / commas / other punctuation marks. You have 5 attempts to get the correct answer.
# (We do not require you to submit your code, so feel free to use the programming language of your 
# choice, just type the numeric answer in the following space.)

# Basic quicksort:
# Sorting is not done in place: This is not a memory efficient solution.
# No random pivot.
# No duplicate entries.
def qs(arr)
	return arr if arr.length <= 1 

	pivot = arr.first
	first = []
	last = []

	arr.drop(1).each do |el|
		if el <= pivot 
			first << el
		else
			last << el
		end
	end

	return qs(first) + [pivot] + qs(last)
end

# Sorting is done in place.
# No random pivot chosen.
# No duplicate entries.
def qsort(arr)
	return arr if arr.length <= 1

	pivot = arr.first

	# split_i = index between < pivot and > pivot
	split_i = 1
	
	# Actual partitioning
	arr.each_with_index do |el, index|
		next if index == 0
		if el < pivot
			arr[split_i], arr[index] = el, arr[split_i]
			split_i += 1
		end
	end

	arr[0], arr[split_i - 1] = arr[split_i - 1], arr[0]

	return qsort(arr[0...split_i - 1]) + [pivot] + qsort(arr[split_i..-1])
end

def qsort(to_sort, index_of_pivot = 0, right_index = to_sort.length - 1)
  old_right_index = right_index   
  left_index = index_of_pivot 
   
  # stop the recursion if nothing to sort
  return to_sort if left_index >= right_index
   
  # partition operation
  # move both indexes towards the center until they cross over
  # when left index finds an element greater than pivot and 
  # right index finds an element smaller than pivot swap them 
  while left_index < right_index           
      while to_sort[left_index] <= to_sort[index_of_pivot] && left_index < to_sort.length - 1
          left_index = left_index + 1
      end
       
      right_index = right_index - 1 until to_sort[right_index] <= to_sort[index_of_pivot] 
       
      # swap both elements
      if left_index < right_index
          to_sort[left_index], to_sort[right_index] = to_sort[right_index], to_sort[left_index]
      end
  end
   
  # swap pivot
  to_sort[index_of_pivot], to_sort[right_index] = to_sort[right_index], to_sort[index_of_pivot]   
   
  # recursively sort the sub arrays 
  sort(to_sort, index_of_pivot, right_index - 1)  
  sort(to_sort, left_index, old_right_index)
   
  return to_sort
end

# Sorting is done in place
# Choose random pivot
def quicksort(to_sort, left_bound = 0, right_bound = to_sort.length - 1)
	return to_sort if right_bound - left_bound < 1
	# Choose a random pivot between left_bound and right_bound and set pivot
	pivot_idx = choose_pivot_idx(left_bound, right_bound)
	pivot = to_sort[pivot_idx]

	# Swap pivot with lower bound of array (first element of subarray to sort)
	to_sort[left_bound], to_sort[pivot_idx] = to_sort[pivot_idx], to_sort[left_bound]

	# i is the index of the split between < pivot and > pivot
	i = left_bound + 1

	(left_bound + 1).upto(right_bound) do |idx|
		if to_sort[idx] < pivot
			# Swap the last element that is < pivot with to_sort[idx]
			to_sort[i], to_sort[idx] = to_sort[idx], to_sort[i]
			i += 1
		end
	end

	# Put the pivot in its correct place by swapping
	to_sort[left_bound], to_sort[i - 1] = to_sort[i - 1], to_sort[left_bound]

	quicksort(to_sort, i, right_bound)
	quicksort(to_sort, left_bound, i - 2)

	return to_sort
end

def choose_pivot_idx(left_bound, right_bound)
	rand(left_bound..right_bound)
end

# 162085
def question_one(arr = $arr, left_bound = 0, right_bound = arr.length - 1, count = 0)
	return count if right_bound - left_bound < 1

	pivot_idx = left_bound
	pivot = arr[left_bound]

	arr[left_bound], arr[pivot_idx] = arr[pivot_idx], arr[left_bound]

	# i is the index of the split between < pivot and > pivot
	i = left_bound + 1

	(left_bound + 1).upto(right_bound) do |idx|
		if arr[idx] < pivot
			# Swap the last element that is < pivot with arr[idx]
			arr[i], arr[idx] = arr[idx], arr[i]
			i += 1
		end
	end

	count += right_bound - left_bound

	# Put the pivot in its correct place by swapping
	arr[left_bound], arr[i - 1] = arr[i - 1], arr[left_bound]

	question_one(arr, i, right_bound, count)
	question_one(arr, left_bound, i - 2, count)

	return count
end

# 164123
def question_two(arr = $arr, left_bound = 0, right_bound = arr.length - 1, count = 0)
	return count if right_bound - left_bound < 1

	pivot_idx = right_bound
	pivot = arr[pivot_idx]

	arr[left_bound], arr[pivot_idx] = arr[pivot_idx], arr[left_bound]

	# i is the index of the split between < pivot and > pivot
	i = left_bound + 1

	(left_bound + 1).upto(right_bound) do |idx|
		if arr[idx] < pivot
			# Swap the last element that is < pivot with arr[idx]
			arr[i], arr[idx] = arr[idx], arr[i]
			i += 1
		end
	end

	count += right_bound - left_bound

	# Put the pivot in its correct place by swapping
	arr[left_bound], arr[i - 1] = arr[i - 1], arr[left_bound]

	question_one(arr, i, right_bound, count)
	question_one(arr, left_bound, i - 2, count)

	return count
end

# 138382
def question_three(arr = $arr, left_bound = 0, right_bound = arr.length - 1, count = 0)
	return count if right_bound - left_bound < 1

	pivot_idx = choose_pivot_idx(arr, left_bound, right_bound)
	pivot = arr[pivot_idx]

	arr[left_bound], arr[pivot_idx] = arr[pivot_idx], arr[left_bound]

	# i is the index of the split between < pivot and > pivot
	i = left_bound + 1

	(left_bound + 1).upto(right_bound) do |idx|
		if arr[idx] < pivot
			# Swap the last element that is < pivot with arr[idx]
			arr[i], arr[idx] = arr[idx], arr[i]
			i += 1
		end
	end

	count += right_bound - left_bound

	# Put the pivot in its correct place by swapping
	arr[left_bound], arr[i - 1] = arr[i - 1], arr[left_bound]

	question_one(arr, i, right_bound, count)
	question_one(arr, left_bound, i - 2, count)

	return count
end

def choose_pivot_idx(arr, left_bound, right_bound)
	length = left_bound - right_bound
	if length % 2 == 0
		index = (length / 2 ) - 1
	else
		index = length / 2
	end

	if arr[left_bound] < arr[right_bound] && arr[left_bound] > arr[index]
		return left_bound
	elsif arr[right_bound] < arr[left_bound] && arr[right_bound] > arr[index]
		return right_bound
	else
		return index
	end
end

# def load_file(file)
# 	$arr = File.readlines(file).map(&:to_i)
# end

# if $PROGRAM_NAME == __FILE__
# 	file = ARGV.empty? ? "numbers2.txt" : ARGV[0]
#   load_file(file)
#   print question_one
#   print question_three
# end