# Codility Lesson 1: FrogJmp
# Time Complexity: O(1)

def solution(x, y, d)
    float_sol = (y - x).to_f / d.to_f
    float_sol % 1 == 0 ? float_sol.to_i : float_sol.to_i + 1
end
