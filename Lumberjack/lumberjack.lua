--rom/programs/http/pastebin get 

--COAL IN SLOT 1, DIRT IN SLOT 2, SAPLINGS IN SLOT 3, COBBLESTONE IN SLOT 4

--refuel
function refuel()
  if turtle.getFuelLevel() < 81 then
    print("refueling")
    turtle.select(1)
    turtle.refuel(1)
  end
end

[[change to use a variable instead of repeating forward()]]
--moves a turtle 5 spaces forward
function forfive()
  turtle.forward()
  turtle.forward()
  turtle.forward()
  turtle.forward()
  turtle.forward()
end


--sets up an area to begin treefarming and also plants saplings
function setup_tree_farm()
  refuel()
  forfive()
  turtle.select(2)
  turtle.placeDown()
end


--this plants the saplings
function replant_saplings()
  refuel()
  turtle.select(3)
  forfive()
  turtle.placeDown()
end


--clears the turtle/computer's interface.
function clear_interface()
  sleep(1)
  term.clear_interface()
  term.setCursorPos(1, 1)
end


--returns the turtle to it's starting location
function go_home()
  refuel()
  turtle.select(4)
  while not turtle.detect() do
    turtle.forward()
  end
  turtle.turnLeft()
  turtle.turnLeft()
  turtle.down()
end


--checks to see if everything is in order to begin a function
function setup_check()
  if turtle.getItemCount(2) < 64 and turtle.getItemCount(4) < 5 then
    print("Not enough dirt. ABORTING PROGRAM")
    sleep(3)
    os.shutdown()
  else
    print("Preperations are complete. Continuing program")
    sleep(3)
  end
end


--mines trees in a row until it hits a familiar block.
function lumberjack()
  refuel()
  while not turtle.detect() do
    turtle.forward()
  end
  turtle.dig()
  turtle.forward()
  turtle_Y = 0
  while turtle.detectUp() do
    turtle.digUp()
    turtle.up()
    turtle_Y = turtle_Y + 1
  end
  for n=1,turtle_Y do
    turtle.down()
  end
end


--dumps stuff out of slots 5-16 from the turtle's inventory
function dump_inventory()
  turtle.turnRight()
  for invvar=5,16 do
    turtle.select(invvar)
    turtle.drop()
  end
  turtle.turnLeft()
end


--pulls saplings from chest to slot 3
function pull_saplings()
  turtle.up()
  turtle.select(3)
  turtle.suckUp()
  turtle.down()
end

[[clean up the if, elseif, else statement]]

--opening menu.
clear_interface()
print("COAL IN SLOT 1, DIRT IN SLOT 2, SAPLINGS IN SLOT 3, COBBLESTONE IN SLOT 4")
term.setCursorPos(5, 1)
print("Select program. '0' runs setup, '1' runs lumberjack.")
term.setCursorPos(8, 1)
print("DO NOT RUN LUMBERJACK UNLESS SETUP HAS BEEN RUN FIRST")

run_setup = "0"
run_lumberjack = "1"
user_input = read()

if user_input == (run_setup) then
  print("initializing setup program")
  setup_check()
  refuel()
  turtle.select(4)
  turtle.turnLeft()
  turtle.turnLeft()
  turtle.place()
  turtle.up()
  turtle.place()
  turtle.turnLeft()
  turtle.turnLeft()
  turtle.down()
  print("how many trees do you want to plant?")
  initvar = tonumber(read())
  for n=1,initvar do
    setup_tree_farm()
  end
  forfive()
  turtle.select(4)
  turtle.place()
  turtle.up()
  turtle.place()
  turtle.turnLeft()
  turtle.turnLeft()
  for n=1,initvar do
    replant_saplings()
  end
  go_home()
elseif user_input == (run_lumberjack) then
  print("initializing lumberjack program")
  pull_saplings()
  clear_interface()
  print("how many trees do you want to cut down?")
  treecount = tonumber(read())
  for n=1,treecount do
    lumberjack()
  end
  forfive()
  turtle.up()
  turtle.turnLeft()
  turtle.turnLeft()
  for n=1,treecount do
    replant_saplings()
  end
  go_home()
  dump_inventory()
else
  print("incorrect command! ABORTING PROGRAM")
  os.shutdown()
end