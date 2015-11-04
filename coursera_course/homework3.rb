require 'byebug'
require 'io/console'

# Link to course: https://class.coursera.org/algo-009/quiz/attempt?quiz_id=52

# Question 1
# Download the text file here. (Right click and save link as)
# The file contains the adjacency list representation of a simple undirected graph. 
# There are 200 vertices labeled 1 to 200. The first column in the file represents the 
# vertex label, and the particular row (other entries except the first column) tells all 
# the vertices that the vertex is adjacent to. So for example, the 6th row looks like : 
# "6	155	56	52	120	......". This just means that the vertex with label 6 is adjacent to 
# (i.e., shares an edge with) the vertices with labels 155,56,52,120,......,etc

# Your task is to code up and run the randomized contraction algorithm for the min cut 
# problem and use it on the above graph to compute the min cut (i.e., the minimum-possible 
# number of crossing edges). (HINT: Note that you'll have to figure out an implementation 
# of edge contractions. Initially, you might want to do this naively, creating a new graph 
# from the old every time there's an edge contraction. But you should also think about more 
# efficient implementations.) (WARNING: As per the video lectures, please make sure to run 
# the algorithm many times with different random seeds, and remember the smallest cut that 
# you ever find.) Write your numeric answer in the space provided. So e.g., if your answer 
# is 5, just type 5 in the space provided.

# Will run the one_cut method a number of times and keep track of the minimum cut so far.
def minimum_cut
end

# Computes one possible minimum cut. 
def one_cut
	# Want to start over with a clean adjacency list every time the minimum_cut method calls 
	# this method.
	file = ARGV.empty? ? "numbers3.txt" : ARGV[0]
	list = file_to_list(file)

	while list.length > 2
		# Pick a random edge: first pick a random array from the list. 
		arr = rand(list.length)
		# Then see which vertex this arr represents and find start vertex u.
		u = list[arr][0]
		# Then randomly find end vertex of the edge (random element of array, but not 0th element).
		end_pos = 1 + rand(arr.length - 1)
		v = arr[end_pos]

		# Merge/contract u and v in one single vertex. 
		
	end
end

# Read in the adjacency list and transform to array of arrays.
def file_to_list(file)
	File.readlines(file).map{ |line| line.split(/\s+/).map(&:to_i) }
end

if $PROGRAM_NAME == __FILE__
	# Run the minimum_cut method
end
