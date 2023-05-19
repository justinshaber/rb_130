require 'pry'

# This class represents a todo item and its associated
# data: name and description. There's also a "done"
# flag to show whether this todo item is done.

class Todo
  DONE_MARKER = 'X'
  UNDONE_MARKER = ' '

  attr_accessor :title, :description, :done

  def initialize(title, description='')
    @title = title
    @description = description
    @done = false
  end

  def done!
    self.done = true
  end

  def done?
    done
  end

  def undone!
    self.done = false
  end

  def to_s
    "[#{done? ? DONE_MARKER : UNDONE_MARKER}] #{title}"
  end

  def ==(otherTodo)
    title == otherTodo.title &&
      description == otherTodo.description &&
      done == otherTodo.done
  end
end


# This class represents a collection of Todo objects.
# You can perform typical collection-oriented actions
# on a TodoList object, including iteration and selection.

class TodoList
  def initialize(title)
    @title = title
    @todos = []
  end

  def add(todo)
    begin
      valid_todo?(todo)
    rescue TypeError => e
      puts e.message
    end

    todos.push(todo)
  end

  alias_method :<<, :add

  def valid_todo?(todo)
    raise("Can only add Todo objects") unless todo.instance_of? Todo
  end

  def size
    todos.size
  end

  def first
    todos[0]
  end

  def last
    todos[-1]
  end

  def to_a
    todos.clone
  end

  def done?
    todos.all? { |todo| todo.done? }
  end

  def item_at(int)
    todos.fetch(int)
  end

  def mark_done_at(int)
    item_at(int).done!
  end

  def mark_undone_at(int)
    item_at(int).undone!
  end

  def done!
    todos.each(&:done!)
  end

  def shift
    todos.shift
  end

  def pop
    todos.pop
  end

  def remove_at(int)
    item_at(int)
    todos.delete_at(int)
  end

  def each
    todos.each do |todo|
      yield(todo)
    end
    self
  end

  def select(str = "Today's Updated List")
    new_list = TodoList.new(str)

    todos.each do |todo|
      new_list << todo if yield(todo)
    end

    new_list
  end

  def find_by_title(str)
    self.each do |todo|
      return todo if todo.title == str
    end
    nil
  end

  def all_done
    select("Today's Done List") do |todo|
      done?
    end
  end

  def all_not_done
    select("Today's Undone List") do |todo|
      !done?
    end
  end

  def mark_done(str)
    find_by_title(str).done!
  end

  def mark_all_done
    done!
  end

  def mark_all_undone
    todos.each(&:undone!)
  end

  def to_s
    text = "---- #{title} ----\n"
    text << todos.map(&:to_s).join("\n")
    text
  end

  protected

  attr_accessor :title, :todos

end

todo1 = Todo.new("Buy milk")
todo2 = Todo.new("Clean room")
todo3 = Todo.new("Go to gym")
todo4 = Todo.new("Clean room")


list = TodoList.new("Today's Todos")
list.add(todo1)
list.add(todo2)
list.add(todo3)
list.add(todo4)

# list.mark_done_at(1)
# list.mark_done_at(3)
# puts list

# list.mark_done("Clean room")

p list.all_done
p list.all_not_done
puts

list.mark_all_done

p list.all_done
p list.all_not_done

puts

list.mark_all_undone

p list.all_done
p list.all_not_done