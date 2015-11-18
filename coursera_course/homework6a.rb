# Course link: https://class.coursera.org/algo-009/quiz/attempt?quiz_id=253

# Question 1
# Download the text file here. (Right click and save link as).

# The goal of this problem is to implement a variant of the 2-SUM algorithm 
# (covered in the Week 6 lecture on hash table applications).
# The file contains 1 million integers, both positive and negative (there 
# 	might be some repetitions!).This is your array of integers, with the ith 
# row of the file specifying the ith entry of the array.

# Your task is to compute the number of target values t in the interval 
# [-10000,10000] (inclusive) such that there are distinct numbers x,y in the 
# input file that satisfy x+y=t. (NOTE: ensuring distinctness requires a one-line 
# 	addition to the algorithm from lecture.)

# Write your numeric answer (an integer between 0 and 20001) in the space 
# provided.


# OPTIONAL CHALLENGE: If this problem is too easy for you, try implementing your 
# own hash table for it. For example, you could compare performance under the 
# chaining and open addressing approaches to resolving collisions.

def two_sum(file)
	numbers, hash = file_to_hash(file)
	result = []
	max = 10000
	min = -10000

	timer = 0

	numbers.each do |number|
		timer += 1 
		puts timer

		-10000.upto(10000) do |count|
			y = count - number
			next if y == number

			result << count if hash[y]
		end
	end

	result.uniq.length
end

def file_to_hash(file)
	numbers = File.open(file).readlines.map(&:to_i)
	arr = Array.new(numbers.length, true)
	hash = Hash[numbers.zip(arr)]

	return numbers, hash
end

if $PROGRAM_NAME == __FILE__
	file = ARGV.empty? ? "numbers6a.txt" : ARGV[0]
	p two_sum(file)
end
