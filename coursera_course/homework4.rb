require 'byebug'
require 'io/console'

# Link to course: https://class.coursera.org/algo-009/quiz/attempt?quiz_id=57

# Question 1
# Download the text file here. Zipped version here. (Right click and save link as)
# The file contains the edges of a directed graph. Vertices are labeled as positive
# integers from 1 to 875714. Every row indicates an edge, the vertex label in first
# column is the tail and the vertex label in second column is the head (recall the 
# graph is directed, and the edges are directed from the first column vertex to 
# the second column vertex). So for example, the 11th row looks liks : "2 47646".
# This just means that the vertex with label 2 has an outgoing edge to the vertex 
# with label 47646.

# Your task is to code up the algorithm from the video lectures for computing strongly 
# connected components (SCCs), and to run this algorithm on the given graph. 

# Output Format: You should output the sizes of the 5 largest SCCs in the given graph, 
# in decreasing order of sizes, separated by commas (avoid any spaces). So if your 
# algorithm computes the sizes of the five largest SCCs to be 500, 400, 300, 200 and 
# 100, then your answer should be "500,400,300,200,100". If your algorithm finds less 
# than 5 SCCs, then write 0 for the remaining terms. Thus, if your algorithm computes only 
# 3 SCCs whose sizes are 400, 300, and 100, then your answer should be "400,300,100,0,0".

# WARNING: This is the most challenging programming assignment of the course. Because of 
# the size of the graph you may have to manage memory carefully. The best way to do this 
# depends on your programming language and environment, and we strongly suggest that 
# you exchange tips for doing this on the discussion forums.

# I used all available test cases in the discussion forum and cannot seem to getting the correct answer. 

def dfs1(graph, start_vertex)
	stack = [start_vertex]
	visited = []

	until stack.empty?
		curr_vertex = stack[-1]

		if !graph[curr_vertex] || graph[curr_vertex][0] 
			$finishing_time += 1
			$magic_order[$finishing_time] = curr_vertex
			stack.pop
		else
			more = []
			graph[curr_vertex][0] = true

			if graph[curr_vertex][2..-1]
				graph[curr_vertex][2..-1].each do |edge|
					if !graph[edge] && !visited.include?(edge)
						more << edge
						visited << edge
					elsif !graph[edge]
						next
					elsif !graph[edge][0]
						more << edge 
					end
				end
			end

			if more.empty?
				$finishing_time += 1
				$magic_order[$finishing_time] = curr_vertex
				stack.pop
			else
				stack.concat(more)
			end
		end
	end
end

def dfs2(graph, source_vertex, leader)
	stack = [source_vertex]
	until stack.empty?
		curr_vertex = stack.pop
		next if !graph[curr_vertex] || graph[curr_vertex][0]
		graph[curr_vertex][1] = leader
		graph[curr_vertex][0] = true
		
		graph[curr_vertex][2..-1].each do |edge|
			stack << edge if !graph[edge] || !graph[edge][0]
		end
	end
end

def first_dfs_loop(graph)
	# magic_order keeps track of order of next dfs pass.
	$magic_order = {} 
	$finishing_time = 0
	  
	graph.each_key do |vertex|
		# If vertex is unexplored
		if graph[vertex] && !graph[vertex][0]
			dfs1(graph, vertex)
		end
	end

	$magic_order
end

def second_dfs_loop(graph, order)
	leader =  nil # Keeps track of current source vertex.
	
	order.length.downto(1) do |finish_t|
		vertex = order[finish_t]
		if !graph[vertex] 
			graph[vertex] = [true, vertex]
		elsif !graph[vertex][0]
			leader = vertex
			dfs2(graph, vertex, leader)
		end
	end

	graph
end

def kosaraju(file, number=5)
	graph_rev = file_to_graph(file, true)
	# First run dfs_loop with reversed graph.
	magic_order = first_dfs_loop(graph_rev)

	# Use the magic order to second dfs loop on original graph.
	# Let it return the graph, so that we can find the largest scc's.
	graph = file_to_graph(file, false)
	graph_with_leaders = second_dfs_loop(graph, magic_order)

	result = find_largest_scc(graph_with_leaders)
	
	return result
end

def find_largest_scc(graph, number=5)
	# scc_lengths has leaders as keys and their occurrence as values.
	# largest_scss keeps track of the size of the largest sccs.
	scc_lengths = {}
	largest_sccs = []

	graph.each do |_, value|
		if scc_lengths[value[1]]
			scc_lengths[value[1]] += 1
		else
			scc_lengths[value[1]] = 1
		end
	end

	number.times do
		if scc_lengths.empty?
			largest_sccs << 0
		else 
	  	max_key, max_value = scc_lengths.max_by{ |k,v| v }
	  	largest_sccs << max_value
	  	scc_lengths.delete(max_key)
	  end
  end

  largest_sccs
end

def file_to_graph(file, reverse=false)
	graph = {}

	# Build a (reversed) graph: 
	# graph = { node: [visited?, leader, outgoing arc, outgoing arc, ...], ...}
	# First element of arr is tail, second one head if reverse is false
	File.open(file).each_line do |line|
		arr = line.split(/\s+/).map(&:to_i)		
	
		arr[0], arr[1] = arr[1], arr[0] if reverse

		if graph[arr.first]
			graph[arr.first] << arr.last
		else
	 	  graph[arr.first] = [false, 0, arr.last]
	 	end
	end	

	graph	
end

if $PROGRAM_NAME == __FILE__
	file = ARGV.empty? ? "numbers4.txt" : ARGV[0]
	p kosaraju(file)
	file = ARGV.empty? ? "test1.txt" : ARGV[0]
	p kosaraju(file) == [6, 3, 2, 1, 0]
	file = ARGV.empty? ? "test2.txt" : ARGV[0]
	p kosaraju(file) == [3, 3, 3, 0, 0]
	file = ARGV.empty? ? "test3.txt" : ARGV[0]
	p kosaraju(file) == [3, 3, 2, 0, 0]
	file = ARGV.empty? ? "test4.txt" : ARGV[0]
	p kosaraju(file) == [3, 3, 1, 1, 0]
	file = ARGV.empty? ? "test5.txt" : ARGV[0]
	p kosaraju(file) == [7, 1, 0, 0, 0]
	file = ARGV.empty? ? "test6.txt" : ARGV[0]
	p kosaraju(file) == [7, 3, 3, 0, 0]
	file = ARGV.empty? ? "test7.txt" : ARGV[0]
	p kosaraju(file) == [3, 1, 1, 1, 1]
end


