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

# Will run the karget_cut method a number of times and keep track of 
# the minimum cut so far.
def minimum_cut
	n = $graph.length
	num_repeats = ((n * Math.log(n)) ** 2).to_i
	size = []

	num_repeats.times do 
		size << karger_cut
	end

	return size.min
end


def karger_cut
	# Want to start over with a copy of the original graph every time method is called.	
	graph = deep_copy($graph)

	while graph.length > 2
		# Get random vertices u and v
		u, v = random_vertices(graph)

		# Send neighbors of v to u
		graph[u].concat(graph[v])

		# Change all the neighbors edges of v to u
		graph[v].each { |neighbor| graph[neighbor].map! { |i| i == v ? u : i } }

		# Remove self loops
		graph[u] = graph[u].reject { |e| e == u }

		# Delete v2
		graph.delete(v)
	end

		# Take the first hash pair and return the size of the value.
		# All elements in the array are neighboring vertices representing edges.
		graph.shift[1].size
end

# Pick 2 random neighboring vertices from the graph
def random_vertices(graph)
	u = graph.keys.sample
	v = graph[u].sample

	[u, v]
end

# Necessary to make a copy of the graph for every karger_cut iteration.
# Dup or clone will make a shallow copy and don't suffice.
def deep_copy(original)
	Marshal.load(Marshal.dump(original))
end

# Makes a hash representing the graph with vertex as key and corresponding edges
# as values.
def file_to_graph(file)
	# Make a new graph
	$graph = {}

	File.open(file).each_line do |line|
		arr = line.split(/\s+/).map(&:to_i)
		$graph[arr[0]] = arr[1..-1]
	end
end

if $PROGRAM_NAME == __FILE__	
	file = ARGV.empty? ? "numbers3.txt" : ARGV[0]
	file_to_graph(file)
	puts minimum_cut
end