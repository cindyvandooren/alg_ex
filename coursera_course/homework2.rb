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
# def qsort(arr)
# 	return arr if arr.length <= 1

# 	pivot = arr.first

# 	# split_i = index between < pivot and > pivot
# 	split_i = 1
	
# 	# Actual partitioning
# 	arr.each_with_index do |el, index|
# 		next if index == 0
# 		if el < pivot
# 			arr[split_i], arr[index] = el, arr[split_i]
# 			split_i += 1
# 		end
# 	end

# 	arr[0], arr[split_i - 1] = arr[split_i - 1], arr[0]

# 	return qsort(arr[0...split_i - 1]) + [pivot] + qsort(arr[split_i..-1])
# end

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
            while to_sort[left_index] <= to_sort[index_of_pivot] and left_index < to_sort.length - 1
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


# def load_file(file)
# 	$arr = File.readlines(file).map(&:to_i)
# end

# if $PROGRAM_NAME == __FILE__
# 	file = ARGV.empty? ? "numbers2.txt" : ARGV[0]
#   load_file(file)
# end