class Student
  @@all = []

  def initialize(student_hash)
    student_hash.each {|key, value|
      self.class.attr_accessor(key)
      self.send(("#{key}="), value)
    }
    @@all << self
  end

  def self.create_from_collection(students_array)
    students_array.each {|students|
      Student.new(students)
    }
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each {|key, value|
      self.class.attr_accessor(key)
      self.send(("#{key}="), value)
    }
    self
  end

  def self.all
    @@all
  end
end
 
