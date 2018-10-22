def input_students
  puts "Please enter the names of the students"
  puts "To Finish, just hit return twice"

  students = []
  name = gets.chomp

  puts "What cohort are they in?"
  cohort = gets.chomp

  while !name.empty? do
    students << {name: name, cohort: cohort}
    if students.count == 1
      puts "Now we have #{students.count} student"
    else
      puts "Now we have #{students.count} students"
    end
    
    puts "What is the next students name?"
    name = gets.chomp
    puts "What cohort are they in?"
    cohort = gets.chomp

    if cohort.length == 0
      cohort = "default"
    end

    cohort.to_sym
  end

  students
end

def print_header
  puts "The students of Villains Academy!"
  puts "-------------"
end

def print(students)
  counter = 0
  while students.length > counter
    puts "#{students[counter][:name]} (#{students[counter][:cohort]} cohort)"
    counter +=1
  end
end

def print_by_cohort(students)
  cohort_list = students.map do |student|
    student[:cohort]
  end
  cohort_list = cohort_list.uniq

  counter = 0
  while counter < cohort_list.length
    students.each do |student|
      if student[:cohort] == cohort_list[counter]
        puts "#{student[:name]} (#{student[:cohort]} cohort)"
      end
    end
  counter += 1
  end
end

def print_footer(students)
  puts "Overall, we have #{students.count} great students"
end

students = input_students
print_header
print_footer(students)
print_by_cohort(students)
