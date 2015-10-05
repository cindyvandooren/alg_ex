# Codibility Lesson 1: TapeEquilibrium
# Time Complexity: O(n2)

def solution(a)
    mindiff = nil

   (1..a.length - 2).each do |p|
       sum1 = a[0..p].inject(0) { |el, sum| sum += el }
       sum2 = a[p + 1..a.length - 1].inject(0) { |el, sum| sum += el }
       diff = (sum1 - sum2).abs

       if mindiff.nil? || diff < mindiff
           mindiff = diff
       end
   end

   mindiff
end

# Time Complexity: O(n)

def solution(a)
    mindiff = nil

    sum1 = 0
    sum2 = a.inject(&:+)

    a[0..-2].each do |el|
        sum1 += el
        sum2 -= el

        diff = (sum1 - sum2).abs

        if mindiff.nil? || diff < mindiff
            mindiff = diff
        end
    end

    mindiff
end
