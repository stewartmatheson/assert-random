require 'helper'

class TestAssertRandom < Test::Unit::TestCase  
  
  
  class TestTestKlass < Test::Unit::TestCase
    def test_test
      assert true
    end
  end
  
  
  def test_class_call
    test_test_case = TestTestKlass.new(:test_test)
    assert(test_test_case.method :assert_random)
  end
  
  
  def test_fail_if_results_are_same
    assert_raise Test::Unit::AssertionFailedError do
      assert_random do
        10
      end
    end
  end
  
  
  def test_pass_if_results_are_random
    assert_nothing_raised do
      assert_random do
        rand(1000)
      end
    end
  end
  
  
=begin
  def test_fails_if_results_are_in_order
    assert_raise Test::Unit::AssertionFailedError do
      counter = 0
      assert_random do
        counter += 1
      end
    end
  end
=end
  
end