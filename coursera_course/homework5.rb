require 'byebug'
require 'io/console'

# Link to course: https://class.coursera.org/algo-009/quiz/attempt?quiz_id=96

# Question 1
# In this programming problem you'll code up Dijkstra's shortest-path algorithm. 
# Download the text file here. (Right click and save link as). 
# The file contains an adjacency list representation of an undirected weighted graph 
# with 200 vertices labeled 1 to 200. Each row consists of the node tuples that are 
# adjacent to that particular vertex along with the length of that edge. For example, 
# the 6th row has 6 as the first entry indicating that this row corresponds to the 
# vertex labeled 6. The next entry of this row "141,8200" indicates that there is an 
# edge between vertex 6 and vertex 141 that has length 8200. The rest of the pairs 
# of this row indicate the other vertices adjacent to vertex 6 and the lengths of the 
# corresponding edges.

# Your task is to run Dijkstra's shortest-path algorithm on this graph, using 1 (the 
# first vertex) as the source vertex, and to compute the shortest-path distances 
# between 1 and every other vertex of the graph. If there is no path between a 
# vertex v and vertex 1, we'll define the shortest-path distance between 1 and v 
# to be 1000000. 

# You should report the shortest-path distances to the following ten vertices, 
# in order: 7,37,59,82,99,115,133,165,188,197. You should encode the distances 
# as a comma-separated string of integers. So if you find that all ten of these 
# vertices except 115 are at distance 1000 away from vertex 1 and 115 is 2000 
# distance away, then your answer should be 1000,1000,1000,1000,1000,2000,1000,
# 1000,1000,1000. Remember the order of reporting DOES MATTER, and the string 
# should be in the same order in which the above ten vertices are given. Please 
# type your answer in the space provided.

# IMPLEMENTATION NOTES: This graph is small enough that the straightforward 
# O(mn) time implementation of Dijkstra's algorithm should work fine. 
# OPTIONAL: For those of you seeking an additional challenge, try implementing 
# the heap-based version. Note this requires a heap that supports deletions, and 
# you'll probably need to maintain some kind of mapping between vertices and their 
# positions in the heap.

# Step 1: Load the file
# Step 2: Eliminate all the vertices that cannot be reached from 1.
# Step 3: Find the shortest paths for the other vertices.

# We need to find length of shortest path between 1 and these vertices.
$goal_vertices = [7, 37, 59, 82, 99, 115, 133, 165, 188, 197]

def find_shortest_paths(file)
	# Step 1: Load the file into a graph.
	graph = file_to_graph(file)

	# Step 2: Eliminate vertices that cannot be reached from vertex 1.
	# Do a DFS/BFS for that first.
	# Then remove unexplored vertices. 

	# Should revise this. Maybe a lot of it is already happening in Dijkstra's algorithm.
	explored_graph = bfs(graph, 1)
	cleaned_graph = eliminate_unexplored_vertices(explored_graph)

	distances = {}

	dijkstra(cleaned_graph, 1)

	# $goal_vertices.each do |vertex|
	# 	# If the vertex is not in the graph, then add 1000 000 to distances.
	# 	# Else add the length of the shortest path
	# 	if !graph[vertex]
	# 		distances[vertex] << 1000000
	# 	else 
	# 		distances[vertex] << dijkstra(graph, vertex)
	# 	end
	# end

	# distances
end

def dijkstra(graph, source)
	debugger
	visited = {}
	shortest_distances = {}

	visited[source] = true
	shortest_distances[source] = 0

	curr_vertex = source

	while visited.length < graph.length
		# Mark curr_vertex as explored.
		graph[curr_vertex][0] = true

		min_weight = 1000000
		smallest_edge = nil

		# Find the edge of the current vertex with the smallest weight.
		# It cannot be already explored.
		graph[curr_vertex][1..-1].each do |v_and_w|
			if !graph[v_and_w[0]] && (v_and_w[1] + shortest_distances[curr_vertex]) < min_weight
				min_weight = v_and_w[1]
				smallest_edge = v_and_w[0]
			end
		end

		visited[smallest_edge] = true
		shortest_distances[smallest_edge] = min_weight + shortest_distances[curr_vertex]
		curr_vertex = smallest_edge		
	end


	shortest_distances
end



# $INFINITY = 1 << 32

# def dijkstra(source, edges, weights, n)
# 	visited = Array.new(n, false)
# 	shortest_distances = Array.new(n, $INFINITY)
# 	previous = Array.new(n, nil)
# 	pq = PQueue.new(proc {|x,y| shortest_distances[x] < shortest_distances[y]})

# 	pq.push(source)
# 	visited[source] = true
# 	shortest_distances[source] = 0

# 	while pq.size != 0
# 		v = pq.pop
# 		visited[v] = true
# 		if edges[v]
# 			edges[v].each do |w|
# 				if !visited[w] and shortest_distances[w] > shortest_distances[v] + weights[v][w]
# 					shortest_distances[w] = shortest_distances[v] + weights[v][w]
# 					previous[w] = v
# 					pq.push(w)
# 				end
# 			end
# 		end
# 	end

# 	return [shortest_distances, previous]
# end

def bfs(graph, source_vertex)
	# Mark the source_vertex as explored.
	graph[source_vertex][0] = true

	queue = []

	until queue.empty?
		curr_vertex = queue.shift

		goal_vertices = []

		graph[source_vertex][2..-1].each do |v_and_w|
			goal_vertices << v_and_w[0]
		end

		goal_vertices.each do |vertex|
			if !graph[goal_vertex][0]
				graph[goal_vertex][0] = true
				queue << vertex
			end
		end
	end

	graph
end

def eliminate_unexplored_vertices(explored_graph)
	explored_graph.keep_if do |key, value|
		value[0] == false
	end
end

def file_to_graph(file)
	graph = {}

	# We'll transform the adjacency matrix into a graph:
	# graph = { row_number: [explored?, [vertex, weight], [vertex, weight], ... ]}
	File.open(file).each_line do |line|
		arr = line.split(/\s+/)
		
		row_number = arr[0].to_i
		graph[row_number] = [false]

		arr[1..-1].each do |string|
			vertex, weight = string.split(",").map(&:to_i)
			graph[row_number] << [vertex, weight]
		end
	end

	graph
end

if $PROGRAM_NAME == __FILE__
	file = ARGV.empty? ? "numbers5.txt" : ARGV[0]
	p find_shortest_paths(file)
end