# This is an extenstion to the core Class class which allows
# any given class to return its own subclasses as an array of
# classes which include the class in question as one of the
# ancestors.
#
# TODO Maybe it is a bad practice to extend core classes like this...
class Class

  # The subclasses method goes through object space and finds all
  # classes which have this class as a parent.
  #
  # @returns Array of subclasses
  def subclasses
    ObjectSpace.each_object(Class).select { |klass| klass < self }
  end
end
