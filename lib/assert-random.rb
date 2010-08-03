module AssertRandom
  module AssertionMixins
    
    def assert_random
      _wrap_assertion do
        results = Array.new
        10.times do
          results.push yield
        end
        assert_block("2 or more values match") { !same_values? results } 
        #assert_block("results are in a sequence") { !in_sequence? results } 
      end
    end
    
    
    private 
    def same_values?(results)
      last_result = results.shift
      results.each do |r|
        return true if(last_result == r)
      end
      false
    end
    
=begin  
    def in_sequence?(results)
      last_result = results.shift
      diff = last_result - results.first
      results.each do |r|
        current_diff = r - last_result
        return false if(diff != current_diff)
        last_result = r
      end
      true
    end 
=end
    
  end
end

Test::Unit::TestCase.send(:include, AssertRandom::AssertionMixins)