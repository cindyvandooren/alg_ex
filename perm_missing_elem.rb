# Codility Lesson 1: PermMissingElem
# Time complexity: O(n)

def solution(a)
    sum_arr = a.inject(0) { |el, sum| sum += el }
    expected_total = (a.length + 1) * (a.length + 2) / 2

    expected_total - sum_arr
end
