require "byebug"

def bs(arr, t)
	mid = arr.length / 2
	# debugger

	return -1 if arr.empty?
	return -1 if t < arr.first

	pivot = arr[mid]

	if pivot == t
		return mid 
	elsif t < pivot 
		return bs(arr[0..mid - 1], t)
	else 
		subsol = bs(arr[mid + 1..-1], t)
		return subsol == -1 ? -1 : mid + subsol + 1
	end
end

# Tests for binary search
# puts bs([1, 2, 3, 4, 5], 0)
# puts bs([1, 2, 3, 4, 5], 6)
# puts bs([1, 2, 3, 4, 5], 1)
# puts bs([1, 2, 3, 4, 5], 2)
# puts bs([1, 2, 3, 4, 5], 3)
# puts bs([1, 2, 3, 4, 5], 4)
# puts bs([1, 2, 3, 4, 5], 5)

# puts nil

# puts bs([1, 2, 3], 1) # => 0
# puts bs([2, 3, 4, 5], 3) # => 1
# puts bs([2, 4, 6, 8, 10], 6) # => 2
# puts bs([1, 3, 4, 5, 9], 5) # => 3
# puts bs([1, 2, 3, 4, 5, 6], 6) # => 5
# puts bs([1, 2, 3, 4, 5, 6], 0) # => nil
# puts bs([1, 2, 3, 4, 5, 7], 6) # => nil




