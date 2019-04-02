require_relative "../config/environment.rb"

class Student
  
  attr_accessor :id, :name, :grade 
  
  def initialize (id=nil, name, grade)
    @id = nil
    @name = name 
    @grade = grade 
  end 
  
  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade TEXT
        )
    SQL
    DB[:conn].execute(sql)
  end
  
  def self.drop_table
    sql = <<-SQL
      DROP TABLE students
    SQL
    DB[:conn].execute(sql)
  end
  
  def save
    if self.id
      self.update
    else
      sql = <<-SQL
        INSERT INTO students (name, grade)
        VALUES (?, ?)
        SQL
        DB[:conn].execute(sql, self.name, self.grade)

        @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
      end 
    end
    
    def self.create(name, grade)
      sql = <<-SQL
        student=self.new(name, grade)
        student.save
    end 

  end 

