# Codility Lesson 2: MaxCounters
# Time Complexity: O(n * m)

def solution(n, a)
    counters = Array.new(n, 0)

    a.each do |el|
        if el > n
            max = counters.max
            counters.map!{ |el| el = max }
        else
            counters[el-1] += 1
        end

    end

    counters

end

# We should be able to do better
# Time Complexity: O (n + m)
def solution(n, a)
    counters = Array.new(n, 0)

    max_value = 0
    set_max = 0

    a.each do |el|
        if el <= n
            value = [counters[el - 1], set_max].max + 1
            counters[el - 1] = value
            max_value = [value, max_value].max
        else
            set_max = max_value
        end
    end

    counters.map! { |el| [el, set_max].max }
end
