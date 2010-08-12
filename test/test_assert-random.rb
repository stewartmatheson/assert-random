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
  
  
  def test_fails_if_results_are_in_order
    assert_raise Test::Unit::AssertionFailedError do
      counter = 0
      assert_random do
        counter =+ 1
      end
    end
  end


  def test_fails_if_results_are_in_order_by_tens
    assert_raise Test::Unit::AssertionFailedError do
      counter = 0
      assert_random do
        counter =+ 10
      end
    end
  end


  def test_fails_if_results_are_in_order_by_one_point_fours
    assert_raise Test::Unit::AssertionFailedError do
      counter = 0
      assert_random do
        counter =+ 1.4
      end
    end
  end
  
  
  def test_tolerance_with_random
    assert_nothing_raised do
      assert_random :tolerance => 5 do
        rand(1000)
      end
    end
  end
  
  
  def test_tolerance_with_fixed_number_set
    numbers = Array.new
    
    2.times do
      numbers.push 10
    end
    
    8.times do
      numbers.push rand(9)
    end
    
    i = -1
    assert_raise Test::Unit::AssertionFailedError do
      assert_random :tolerance => 2 do
        i =+ 1
        numbers[i]
      end
    end
  end


  def test_must_pass_block
    assert_raise Test::Unit::AssertionFailedError do
      assert_random
    end
  end
  
  
  def test_iteration_gets_passed
    assert_nothing_raised do
      assert_random :iterations => 5 do
        rand(1000)
      end
    end
  end
  
  
  def test_iteration_and_tolerance_get_passed
    assert_nothing_raised do
      assert_random :iterations => 5, :tolerance => 10 do
        rand(1000)
      end
    end
  end
  
end