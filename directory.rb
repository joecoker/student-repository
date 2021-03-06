@students = []

def input_students
  puts "To Finish, just hit return twice"
  get_name_cohort
  while !name.empty? do
    add_to_students(name, cohort)
    if @students.count == 1
      puts "Now we have #{@students.count} student"
    else
      puts "Now we have #{@students.count} students"
    end
    get_name_cohort
    if cohort.length == 0
      cohort = "default"
    end
    cohort.to_sym
  end
  puts "Students added successfully"
end

def get_name_cohort
  puts "What is the next students name?"
  name = STDIN.gets.chomp
  puts "What cohort are they in?"
  cohort = STDIN.gets.chomp
end


def add_to_students(name, cohort)
  @students << {name: name, cohort: cohort.to_sym}
end

def print_header
  puts "The students of Villains Academy!"
  puts "-------------"
end

def print_student_list()
  counter = 0
  while @students.length > counter
    puts "#{@students[counter][:name]} (#{@students[counter][:cohort]} cohort)"
    counter +=1
  end
end

def print_by_cohort
  cohort_list = @students.map do |student|
    student[:cohort]
  end
  cohort_list = cohort_list.uniq
  counter = 0
  while counter < cohort_list.length
    @students.each do |student|
      if student[:cohort] == cohort_list[counter]
        puts "#{student[:name]} (#{student[:cohort]} cohort)"
      end
    end
  counter += 1
  end
end

def print_footer
  puts "Overall, we have #{@students.count} great students"
end

def interactive_menu
  students = []
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit"
end

def show_students
  print_header
  print_student_list
  print_footer
end

def process(selection)
  case selection
  when "1"
    students = input_students
  when "2"
    show_students
  when "3"
    save_students
  when "4"
    load_students(ARGV.first)
  when "9"
    exit
  else
    puts "I don't know what you meant, try again"
  end
end

def save_students
  puts "What is the filename?"
  file_name = gets.chomp

  CSV.open(file_name, "w") do |file|
    @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
end
  puts "Students saved"
end


def try_load_students
  filename = ARGV.first
  if filename.nil?
    filename = "students.csv"
  end
  load_students(filename)
  puts "Loaded #{@students.count} from #{filename}"
end

def load_students(filename)
  if filename.nil?
    puts "What is the filename?"
    filename = gets.chomp
  end
  CSV.open(filename, "r") do |file|
    file.each do |line|
      name, cohort = line.chomp.split(',')
      add_to_students(name, cohort)
    end
  end
end



try_load_students
interactive_menu
