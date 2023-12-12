#!/bin/env bash

print_and_wait -C "Docker Basics"
echo

print_and_wait "Basic docker information:"
execute_command docker info

print_and_wait "Listing local images"
execute_command docker images

print_and_wait "And the containers (running):"
execute_command docker ps 

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

print_and_wait "Cleanup: first stop the containers and then remove them"
execute_command docker stop alpine-container alpine-exited
execute_command docker rm alpine-container alpine-exited
execute_command docker rmi alpine
