# Codility Lesson 3: CountDiv

# Time Complexity: O(1)
# Space Complexity: O(1)
# This solution gives a wrong solution for a = 11, b = 345 and Kk = 17
# The correct answer is 20, provided answer is 19
def solution(a, b, k)
    divide = (b - a) / k

    if a % k != 0 && b % k != 0
        divide
    else
        divide + 1
    end
end

# Other approach:
# Time Complexity: O(1)
# Space Complexity: O(1)
def solution(a, b, k)
    upper = b / k
    lower = (a - 1) / k

    upper - lower
end
