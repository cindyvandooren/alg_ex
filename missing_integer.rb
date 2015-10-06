# Codility Lesson 2: MissingInteger
# Time Complexity: O(n)
# Space Complexity: O(n)

def solution(a)
    count = [0, 0]
    a.each do |el|
        next if el < 0
        count[el].to_i == 0 ? count[el] = 1 : count[el] += 1
    end

    count.each_with_index do |el, index|
        if el.to_i == 0 && index.to_i > 0
            return index
        end
    end

    return "No element missing"
end
