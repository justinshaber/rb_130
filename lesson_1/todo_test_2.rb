require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require "minitest/reporters"
Minitest::Reporters.use!


require_relative 'todo_2'

class TodoListTest < Minitest::Test

  def setup
    @todo1 = Todo.new("Buy milk")
    @todo2 = Todo.new("Clean room")
    @todo3 = Todo.new("Go to gym")
    @todos = [@todo1, @todo2, @todo3]

    @list = TodoList.new("Today's Todos")
    @list.add(@todo1)
    @list.add(@todo2)
    @list.add(@todo3)
  end

  def test_to_a
    assert_equal(@todos, @list.to_a)
  end
  
  def test_size
    assert_equal(3, @list.size)
  end

  def test_first
    assert_equal(@todo1, @list.first)
  end

  def test_last
    assert_equal(@todo3, @list.last)
  end

  def test_shift
    assert_equal(@todo1, @list.shift)
    assert_equal([@todo2, @todo3], @list.to_a)
  end

  def test_pop
    assert_equal(@todo3, @list.pop)
    assert_equal([@todo1, @todo2], @list.to_a)
  end

  def test_done?
    refute(@list.done?)
    @list.mark_all_done
    assert(@list.done?)
  end

  def test_type_error
    assert_raises(TypeError) { @list.add("New Item") }
    assert_raises(TypeError) { @list.add(1) }
  end

  def test_shovel
    todo4 = Todo.new("Buy dinner")
    todo5 = Todo.new("Go to work")

    @list << todo4
    @list.add todo5
    @todos << todo4
    @todos << todo5

    assert_equal(@todos, @list.to_a)
    assert_equal(5, @list.size)
    assert_equal(todo5, @list.last)
  end

  def test_item_at
    assert_raises(IndexError) { @list.item_at(6) }
    assert_equal(@todo1, @list.item_at(0))
  end

  def test_mark_done_at
    assert_raises(IndexError) { @list.mark_done_at(3) }
    @list.mark_done_at(2)
    assert_equal(false, @todo1.done?)
    assert_equal(false, @todo2.done?)
    assert_equal(true, @todo3.done?)
  end

  def test_mark_undone_at
    assert_raises(IndexError) { @list.mark_undone_at(3) }

    @list.mark_done_at(2)
    assert_equal(false, @todo1.done?)
    assert_equal(false, @todo2.done?)
    assert_equal(true, @todo3.done?)

    @list.mark_undone_at(2)
    assert_equal(false, @todo1.done?)
    assert_equal(false, @todo2.done?)
    assert_equal(false, @todo3.done?)
  end

  def test_mark_all_done
    @list.mark_all_done

    assert_equal(true, @todo1.done?)
    assert_equal(true, @todo2.done?)
    assert_equal(true, @todo3.done?)
    assert_equal(true, @list.done?)
  end

  def test_mark_all_undone
    @list.mark_all_done

    assert_equal(true, @todo1.done?)
    assert_equal(true, @todo2.done?)
    assert_equal(true, @todo3.done?)
    assert_equal(true, @list.done?)

    @list.mark_all_undone

    assert_equal(false, @todo1.done?)
    assert_equal(false, @todo2.done?)
    assert_equal(false, @todo3.done?)
    assert_equal(false, @list.done?)
  end

  def test_remove_at
    assert_raises(IndexError) { @list.remove_at(3) }

    @list.remove_at(1)
    assert_equal(2, @list.size)
    assert_equal([@todo1, @todo3], @list.to_a)
  end

  def test_to_s
    output = <<~OUTPUT.chomp
    ---- Today's Todos ----
    [ ] Buy milk
    [ ] Clean room
    [ ] Go to gym
    OUTPUT
  
    assert_equal(output, @list.to_s)
  end

  def test_to_s_2
    output = <<~OUTPUT.chomp
    ---- Today's Todos ----
    [ ] Buy milk
    [X] Clean room
    [ ] Go to gym
    OUTPUT
  
    @list.mark_done_at(1)
    assert_equal(output, @list.to_s)
  end

  def test_to_s_3
    output = <<~OUTPUT.chomp
    ---- Today's Todos ----
    [X] Buy milk
    [X] Clean room
    [X] Go to gym
    OUTPUT
  
    @list.mark_all_done
    assert_equal(output, @list.to_s)
  end

  def test_each
    counter = 0
    results = []

    @list.each do |todo|
      counter += 1
      results << todo
    end

    assert_equal(3, counter)
    assert_equal([@todo1, @todo2, @todo3], results)
  end

  def test_each_2
    return_value = @list.each { |todo| "do nothing" }

    assert_equal(@list, return_value)
  end

  def test_select
    new_list = @list.select { |todo| true }

    assert_equal([@todo1, @todo2, @todo3], new_list.to_a)
    refute_same(@list, new_list)
  end

  def test_all_done
    @list.mark_done_at(1)
    new_list = @list.all_done
    assert_equal([@todo2], new_list.to_a)
  end

  def test_all_not_done
    @list.mark_done_at(1)
    new_list = @list.all_not_done
    assert_equal([@todo1, @todo3], new_list.to_a)
  end

  def test_mark_done
    assert_equal(false, @todo1.done?)
    @list.mark_done("Buy Milk")
    assert_equal(false, @todo1.done?)
    @list.mark_done("Buy milk")
    assert_equal(true, @todo1.done?)
  end

  def test_find_by_title
    todo = @list.find_by_title("Buy Milk")
    assert_nil(todo)
    todo = @list.find_by_title("Buy milk")
    assert_equal(@todo1, todo)
  end
end