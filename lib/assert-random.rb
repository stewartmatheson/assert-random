module AssertRandom
  module AssertionMixins
    
    def assert_random
      _wrap_assertion do
        results = Array.new
        10.times do
          results.push yield
        end
        assert_block("2 or more values match") { !same_values? results } 
        assert_block("Results are in a sequence") { !in_sequence? results } 
      end
    end
    
    
    private 
    def same_values?(results)
      results.each do
        last_result = results.shift
        results.each do |r|
          return true if(last_result == r)
        end
      end
      false
    end
    

    def in_sequence?(results)
      differences = Array.new
      results.each do
        last_result = results.shift
        results.each do |r|
          differences.push last_result - r
        end
      end
      sorted_difference = {}
      differences.each do |d|
        if sorted_difference.has_key? d
          sorted_difference[d] += 1
        else
          sorted_difference[d] = 1
        end 
      end
      return sorted_difference.size < 1
    end 


  end
end

Test::Unit::TestCase.send(:include, AssertRandom::AssertionMixins)