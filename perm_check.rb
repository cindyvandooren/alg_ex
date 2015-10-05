# Codility Lesson 2: PermCheck
# Time Complexity: O(n)

def solution(a)
    n = a.length
    count = Array.new(n + 1, 0)
    expected_sum = n * (n + 1) / 2
    current_sum = 0

    a.each do |el|
        if count[el] == 0
            count[el] += 1
            current_sum += el
        else
            return 0
        end
    end

    expected_sum == current_sum ? 1 : 0
end
