#Asignacion 1 - Planeacion y Estimacion de Soluciones Computacionales
#Jose Alfredo Gallegos Chavarria
#1383375
#Semestre Ago-Dic 2015

#Programa que calcula la media y la desviacion estandar de un conjunto de n numeros reales leidos desde stdin separados por " "
#Utilizar listas encadenadas para almacenar los datos

#linked list code
#declaring a struct for the nodes of data
#value (datum) and address for next node
class Node
  attr_accessor :value, :next #gets and sets for value and next

  def initialize(value = nil)
    @value = value
  end
end

#now we can define a LinkedList class here, which will have a head node location as an attribute
class LinkedList
  attr_accessor :head

  def initialize(first_value = nil)
    @head = Node.new(first_value) if first_value #initialize the list with a due value if the list object is created with an explicit val  LinkedList.new(val)
  end

  def push(value)
    if @head.nil? #if there's no starting node to the list... add a new one and initialize it with the desired datum 
      @head = Node.new(value)
    else # else add a node to the end of the list
      current_node = @head

      while current_node.next #traverse the list until theres no next node
        current_node = current_node.next
      end
      current_node.next = Node.new(value) #and after you found it, insert the value there
    end
  end

  def find(value)
    current_node = @head #start searching from the top

    while current_node != nil #return the right node when you find it by value
      return current_node if current_node.value == value
      #else, keep searching
      current_node = current_node.next
    end
    nil #else return nil => no value found
  end

  def remove(value) #remove by value
    if @head.value == value #start from the top... if the first node you find has the value that you wish to delete
      @head = @head.next #get that node out of the game
    else
      current_node = @head.next #otherwise keep searching
      prev_node = @head

      while current_node
        if current_node.value == value
          prev_node.next = current_node.next
          return true
        end
        prev_node = current_node
        current_node = current_node.next
      end

      nil #return nil if node is not found
    end
  end

  def print() #output all the values in the list
    current_node = @head #start from the top... yet,
    if current_node.nil? # if there's no head => the list is empty
      return nil #exit out of this
    end

    while current_node != nil
      puts current_node.value
      current_node = current_node.next
    end
  end

  def length()
    i = 0
    current_node = @head #start from the top... yet,
    
    if current_node.nil? # if there's no head => the list is empty
      return 0
    end

    while current_node != nil
      i += 1
      current_node = current_node.next
    end
    i #return the sum of nodes in the list
  end
end

def average(numbers) #to calculate the average....
  sum = 0
  current_node = numbers.head #go through all the elements in the list from the top

  while current_node != nil #sum their datums into a grand total...
    sum += current_node.value
    current_node = current_node.next
  end

  return sum / numbers.length #and return the average of that sum
end

def stdDev(numbers, avg) #to calculate the standard deviation
  sum = 0
  current_node = numbers.head #go through all the elements in the list from the top

  while current_node != nil #sum the squares of their differences to the average
    sum += (current_node.value - avg) ** 2
    current_node = current_node.next
  end

  return Math.sqrt(sum / (numbers.length - 1))  #and return the square root of that sum
end

puts "PESC Ago-Dic 2015 -- Asignacion 1"
print ">? "
#capture from stdin and parse as floats into an array that we'll use to store our data temporarily
numbers = gets.split(" ").map!(&:to_f)
list = LinkedList.new()

if numbers.size == 0
  exit
else  
  #get all the numbers captured before into the linkedlist
  numbers.each do |i|
    list.push(i)
  end

  avg = average(list) #then run our magic....
  stdev = stdDev(list, avg)

  puts "\nPromedio: %.2f Desviacion estandar: %.2f" % [ avg, stdev ]
end