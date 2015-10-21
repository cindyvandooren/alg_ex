# Codility Lesson 2: MissingInteger
# Time Complexity: O(n)
# Space Complexity: O(n)
# By pigeonhole principle, at least one of the numbers 1, 2, ..., n+1
# is not in the array. Let us create a boolean array b of size n+1 to
# store whether each of these numbers is present.

def solution(a)
    n = a.length
    count = Array.new(n + 2, 0)
    a.each do |el|
        next if el < 0 || el > n + 1
        count[el] == 0 ? count[el] = 1 : count[el] += 1
    end

    count.each_with_index do |el, index|
        if el.to_i == 0 && index.to_i > 0
            return index
        end
    end

    return "No element missing"
end
