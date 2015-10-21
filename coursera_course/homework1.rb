require 'byebug'
require 'io/console'

# Link to course: https://class.coursera.org/algo-009

# Question 1:
# Download the text file here. (Right click and save link as)
# This file contains all of the 100,000 integers between 1 and 100,000 (inclusive) 
# in some order, with no integer repeated. Your task is to compute the number of 
# inversions in the file given, where the ith row of the file indicates the ith 
# entry of an array. Because of the large size of this array, you should implement 
# the fast divide-and-conquer algorithm covered in the video lectures.
# The numeric answer for the given input file should be typed in the space below.
# So if your answer is 1198233847, then just type 1198233847 in the space provided 
# without any space / commas / any other punctuation marks.
# You can make up to 5 attempts, and we'll use the best one for grading.
# (We do not require you to submit your code, so feel free to use any programming 
# language you want --- just type the final numeric answer in the following space.)
# [TIP: before submitting, first test the correctness of your program on some small 
# test files or your own devising. Then post your best test cases to the discussion 
# forums to help your fellow students!]
#

# Basic merge_sort
def merge_sort(arr)
	l = arr.length

	return arr if l <= 1

	left = merge_sort(arr.take(l/2))
	right = merge_sort(arr.drop(l/2))

	return merge(left, right)
end

def merge(left, right)
	sorted = []

	until left.empty? || right.empty?
		if left.first <= right.first
			sorted << left.shift
		else 
			sorted << right.shift
		end
	end

	sorted.concat(left).concat(right)
end

# --------------------------------------------------------------------------------

# Actual homework: Expand merge_sort to count inversions
# First load the contents of the file into an array
def load_file(file)
	$arr = File.readlines(file).map(&:to_i)
end

def sort_and_count(arr)
	l = arr.length
	m = arr.length / 2

	return [0, arr] if l <= 1

	left = arr.take(l/2)
	right = arr.drop(l/2)

	count_left = sort_and_count(left)
	count_right = sort_and_count(right)

	count_split = merge_and_count(count_left[1], count_right[1])

	return [count_left[0] + count_right[0] + count_split[0], count_split[1]]
end

def merge_and_count(left, right)
	sorted = []
	count = 0

	until left.empty? || right.empty?
		if left.first <= right.first
			sorted << left.shift
		else
			sorted << right.shift
			count += left.length
		end
	end

	sorted.concat(left).concat(right)

	# Also returning the sorted array was a part that was missing in my
	# first attempt to write this algorithm.
	return [count, sorted]
end

#Helper to run script on command line.
if $PROGRAM_NAME == __FILE__
	file = ARGV.empty? ? "numbers.txt" : ARGV[0]
  load_file(file)
  p sort_and_count($arr)[0]
end

# Test cases
# if $PROGRAM_NAME == __FILE__
# 	puts sort_and_count([1, 5, 3, 2, 4])[0] == 4
# 	puts sort_and_count([1, 3, 5, 2, 4, 6])[0] == 3
# 	puts sort_and_count([5, 4, 3, 2, 1])[0] == 10
# 	puts sort_and_count([1, 6, 3, 2, 4, 5])[0] == 5
# 	puts sort_and_count([1, 2, 3, 4, 5, 6, 7, 8, 9])[0] == 0
# 	puts sort_and_count([9, 8, 7, 6, 5, 4, 3, 2, 1])[0] == 36
# 	puts sort_and_count([9, 12, 3, 1, 6, 8, 2, 5, 14, 13, 11, 7, 10, 4, 0])[0] == 56
# 	puts sort_and_count([37, 7, 2, 14, 35, 47, 10, 24, 44, 17, 34, 11, 16, 48, 1, 39, 6, 33, 43, 26, 40, 4, 28, 5, 38, 41, 42, 12, 13, 21, 29, 18, 3, 19, 0, 32, 46, 27, 31, 25, 15, 36, 20, 8, 9, 49, 22, 23, 30, 45])[0] == 590
# 	puts sort_and_count([4, 80, 70, 23, 9, 60, 68, 27, 66, 78, 12, 40, 52, 53, 44, 8, 49, 28, 18, 46, 21, 39, 51, 7, 87, 99, 69, 62, 84, 6, 79, 67, 14, 98, 83, 0, 96, 5, 82, 10, 26, 48, 3, 2, 15, 92, 11, 55, 63, 97, 43, 45, 81, 42, 95, 20, 25, 74, 24, 72, 91, 35, 86, 19, 75, 58, 71, 47, 76, 59, 64, 93, 17, 50, 56, 94, 90, 89, 32, 37, 34, 65, 1, 73, 41, 36, 57, 77, 30, 22, 13, 29, 38, 16, 88, 61, 31, 85, 33, 54])[0] == 2372
# 	puts sort_and_count([18, 22, 4, 29, 15, 21, 13, 24, 20, 10, 11, 26, 27, 16, 12, 8, 25, 14, 6, 17, 30, 9, 28, 5, 2, 1, 23, 7, 19, 3])[0] == 266
# 	puts sort_and_count([1000, 7, 900, 6, 4, 9, 0, 5, 4, 8, 3, 7, 1])[0] == 55
# 	puts sort_and_count([79, 18, 14, 41, 51, 84, 21, 42, 28, 81, 36, 66, 3, 32, 45, 74, 76, 69, 89, 43, 75, 23, 54, 94, 92, 35, 39, 0, 56, 40, 25, 34, 87, 30, 62, 20, 31, 57, 29, 86, 63, 91, 53, 7, 49, 61, 85, 52, 59, 44, 96, 10, 77, 38, 48, 98, 1, 17, 71, 8, 72, 16, 82, 93, 55, 47, 60, 4, 11, 67, 99, 90, 83, 70, 78, 33, 22, 73, 37, 9, 65, 80, 95, 19, 2, 46, 26, 68, 24, 6, 64, 13, 58, 88, 5, 15, 12, 97, 50, 27])[0] == 2543
# 	puts sort_and_count([137, 3, 122, 133, 84, 20, 106, 37, 128, 180, 91, 34, 19, 176, 191, 158, 113, 131, 94, 16, 62, 2, 6, 81, 78, 162, 26, 143, 126, 184, 70, 47, 9, 125, 63, 65, 120, 23, 44, 103, 181, 148, 59, 5, 140, 124, 83, 156, 152, 102, 118, 107, 161, 76, 88, 68, 142, 58, 187, 38, 114, 61, 73, 93, 104, 36, 27, 136, 10, 116, 86, 168, 182, 119, 60, 144, 127, 188, 74, 48, 51, 135, 71, 199, 153, 178, 8, 50, 198, 98, 109, 155, 21, 80, 105, 179, 1, 164, 174, 190, 79, 69, 172, 100, 4, 147, 186, 115, 45, 173, 33, 166, 192, 145, 30, 163, 195, 134, 89, 110, 12, 41, 138, 35, 46, 18, 146, 141, 56, 95, 194, 90, 177, 189, 170, 132, 29, 82, 15, 97, 108, 75, 57, 167, 154, 54, 151, 99, 66, 130, 17, 139, 14, 39, 129, 149, 171, 11, 22, 25, 42, 87, 40, 49, 159, 67, 43, 85, 55, 24, 185, 160, 123, 112, 196, 101, 28, 193, 53, 169, 165, 64, 96, 111, 117, 0, 72, 121, 157, 52, 92, 197, 7, 77, 32, 183, 150, 31, 175, 13])[0] == 9874
# 	puts sort_and_count([26, 162, 135, 266, 214, 69, 219, 232, 67, 14, 57, 132, 292, 288, 235, 183, 220, 191, 39, 24, 259, 12, 299, 43, 1, 80, 175, 165, 206, 200, 50, 270, 79, 181, 173, 172, 263, 114, 110, 268, 68, 59, 257, 247, 27, 287, 204, 274, 4, 47, 49, 148, 97, 53, 126, 238, 242, 7, 275, 144, 21, 177, 240, 216, 18, 167, 203, 111, 271, 285, 42, 189, 93, 152, 252, 70, 278, 265, 142, 286, 245, 258, 65, 112, 192, 195, 236, 294, 133, 224, 138, 88, 109, 201, 16, 72, 145, 212, 284, 74, 64, 197, 176, 99, 81, 143, 31, 248, 264, 58, 146, 233, 45, 255, 116, 209, 120, 218, 61, 171, 62, 63, 11, 75, 96, 211, 283, 40, 128, 87, 279, 0, 153, 290, 295, 108, 169, 187, 269, 134, 277, 37, 149, 256, 234, 291, 82, 3, 36, 56, 150, 28, 179, 198, 147, 105, 185, 228, 210, 8, 91, 289, 95, 38, 141, 280, 229, 89, 46, 161, 10, 267, 131, 166, 41, 156, 230, 254, 35, 160, 6, 86, 231, 33, 297, 226, 115, 155, 76, 174, 207, 276, 30, 239, 251, 32, 246, 113, 44, 29, 158, 106, 98, 215, 77, 223, 137, 140, 90, 123, 15, 151, 136, 107, 213, 227, 103, 9, 118, 34, 208, 19, 159, 244, 170, 243, 119, 180, 261, 249, 73, 282, 51, 196, 260, 298, 225, 78, 194, 104, 188, 163, 272, 25, 102, 71, 121, 250, 100, 13, 92, 186, 94, 129, 122, 241, 281, 101, 178, 168, 130, 253, 85, 237, 2, 22, 273, 293, 222, 54, 20, 217, 164, 193, 157, 117, 182, 154, 296, 5, 190, 221, 205, 84, 127, 125, 55, 139, 124, 184, 60, 199, 202, 262, 17, 66, 83, 48, 52, 23])[0] == 23260
# 	puts sort_and_count([137, 325, 261, 199, 278, 54, 301, 334, 386, 242, 66, 24, 74, 385, 212, 139, 293, 67, 318, 118, 302, 156, 378, 277, 134, 147, 108, 128, 179, 215, 123, 9, 166, 19, 171, 276, 232, 25, 50, 160, 275, 244, 245, 195, 112, 284, 249, 259, 151, 222, 340, 229, 5, 115, 260, 13, 91, 17, 299, 80, 10, 305, 6, 379, 153, 157, 95, 252, 221, 328, 98, 41, 28, 383, 150, 158, 196, 207, 315, 286, 63, 333, 282, 258, 65, 127, 205, 307, 331, 94, 208, 323, 375, 192, 84, 312, 213, 93, 100, 110, 203, 185, 200, 154, 99, 193, 287, 265, 135, 146, 227, 246, 87, 237, 390, 3, 12, 336, 255, 372, 263, 34, 324, 321, 218, 164, 120, 346, 219, 188, 262, 217, 105, 51, 241, 2, 122, 373, 104, 256, 141, 26, 79, 335, 362, 121, 90, 92, 233, 234, 132, 39, 88, 125, 15, 220, 155, 223, 181, 266, 89, 388, 56, 206, 60, 342, 201, 339, 311, 116, 22, 319, 37, 29, 14, 308, 353, 170, 337, 297, 32, 365, 350, 322, 354, 69, 243, 53, 228, 47, 360, 75, 31, 97, 359, 64, 326, 136, 330, 239, 184, 209, 292, 140, 238, 211, 397, 295, 76, 111, 119, 52, 251, 377, 250, 270, 49, 317, 271, 145, 38, 226, 1, 351, 42, 7, 73, 248, 358, 103, 33, 289, 204, 272, 202, 197, 310, 133, 142, 23, 343, 363, 8, 177, 247, 117, 189, 59, 180, 300, 96, 148, 371, 173, 344, 45, 396, 126, 11, 341, 382, 18, 298, 268, 190, 303, 191, 374, 86, 314, 253, 306, 35, 46, 165, 101, 57, 279, 235, 44, 58, 329, 347, 291, 187, 70, 174, 175, 176, 393, 391, 399, 273, 236, 349, 384, 398, 106, 387, 355, 269, 182, 124, 16, 114, 257, 352, 4, 230, 20, 186, 225, 109, 281, 231, 348, 72, 102, 357, 224, 178, 283, 294, 149, 183, 48, 296, 0, 288, 85, 320, 376, 27, 167, 367, 82, 216, 68, 143, 381, 309, 144, 71, 313, 81, 254, 395, 356, 214, 274, 366, 169, 392, 327, 369, 172, 267, 107, 364, 290, 129, 345, 161, 198, 304, 61, 163, 162, 55, 370, 194, 240, 332, 316, 131, 113, 43, 152, 138, 368, 159, 168, 285, 264, 280, 36, 83, 210, 77, 394, 30, 130, 389, 62, 361, 21, 40, 380, 78, 338])[0] == 37904
# end

# Answer = 2407905288
