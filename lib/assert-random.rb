require 'test/unit'
module AssertRandom
  module AssertionMixins
    
    
    def assert_random(options = {})
      _wrap_assertion do
        assert_block("assert needs to be called with a block.") { block_given? }  
        configuration = { :tolerance => 1, :iterations => 10 }
        configuration.merge!(options) if options.is_a?(Hash)        
        assert_block("No point running with an iteration count of 1") { !only_iterating_once? configuration[:iterations] } 
        
        results = Array.new
        configuration[:iterations].times do
          results.push yield
        end
        
        assert_block("#{configuration[:tolerance]} or more values match") { !same_values? results, configuration[:tolerance] } 
        assert_block("Results are in a sequence") { !in_sequence? results } 
      end
    end
    
    
    private 
    def only_iterating_once?(iterations)
      iterations <= 1
    end 
    
    def same_values?(results, tolerance)
      same_value_counter = 0
      results.each do
        last_result = results.shift
        results.each do |r|
          if(last_result == r)
            same_value_counter += 1
            return true if same_value_counter > tolerance 
          end
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