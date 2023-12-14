#!/bin/env bash

print_and_wait -C "Docker Container Basics"
echo

print_and_wait "Listing all active containers:"
execute_command docker ps 
echo

print_and_wait "Creating and starting a container is simple"
print_and_wait "First we pull (or build) an image:"
execute_command docker pull alpine 
print_and_wait "Then we create a container based on that image"
execute_command docker run -d --name alpine-container alpine sleep infinity
print_and_wait "And then we start it"
execute_command docker start alpine-container
print_and_wait "We can list the containers running:"
execute_command docker ps
echo

print_and_wait "We needed to create a container and run a command like sleep because otherwise the container would've exited. We can demonstrate that now:"
execute_command docker run -d --name alpine-exited alpine
print_and_wait "Normally invisible in the docker ps..."
execute_command docker ps
print_and_wait "...if we don't use the correct options:"
execute_command docker ps --all
print_and_wait "Notice the status - the container immediately exited after we created it"
echo

print_and_wait "We can also enter the container environment. You can continue by typing the 'exit' command:"
execute_command docker run  -it --name alpine-entered alpine sh
print_and_wait "When we exited from the last container, it moved to an 'exited' status, therefore it's not running. We can get it back up:"
execute_command docker start alpine-entered
print_and_wait "And we can play with it"
execute_command 'docker exec alpine-entered sh -c "echo Cats are love > meowness"'
execute_command docker exec alpine-entered ls
print_and_wait "Now we restart the container and check if the file is still there"
execute_command docker restart alpine-entered
execute_command docker exec alpine-entered cat meowness
execute_command docker exec alpine-entered ls
print_and_wait "As we see, it's still there. Now we will (just for demonstration) pause the container."
execute_command docker pause alpine-entered
echo

print_and_wait "Cleanup: first stop the containers and then remove them"
execute_command docker stop -t 0 alpine-container alpine-exited alpine-entered
execute_command docker rm alpine-container alpine-exited alpine-entered
execute_command docker rmi alpine
