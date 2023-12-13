#!/bin/env bash

print_and_wait -C "Docker Images"
echo

print_and_wait "Let's start with reviewing our local repository"
execute_command docker images
print_and_wait "These are all the images we have currently on our machine. We can display sha hash with options:"
execute_command docker images --digests
print_and_wait "Notice that the CREATED field doesn't represent the amount of time since we've pulled the image"
echo

print_and_wait "We can pull a new image with the CLI directly"
execute_command docker image pull alpine

print_and_wait "Which gets stored in our local repository:"
execute_command docker images
echo

print_and_wait "Details of a pulled image can be inspected:"
execute_command docker inspect alpine

print_and_wait "We can display the manifest of a resource simply like this (be patient, will take a few seconds):"
execute_command docker manifest inspect node
print_and_wait "It doesn't matter if the image we are inspecting is already on our system because docker fetches the latest information from the registry."
print_and_wait "The verbose output (-v) let's us also see the layers. Note that the following command only shows a part of the output for demonstration."
execute_command "docker manifest inspect node -v | jq '.[0] | .Raw = \"......(truncated)\"'"
print_and_wait "Note that 'docker manifest inspect' is an experimental feature, so it might change or be removed in the future."

print_and_wait "We should prefer using exact tags. As you can see above, pulling image without a tag uses a default 'latest' tag automatically."
execute_command docker pull alpine:3.19.0

print_and_wait "Pulling from another registry can be done by specifying its name as the part of the image name:"
execute_command docker pull docker.elastic.co/beats/elastic-logging-plugin:7.6.1

print_and_wait "We are able to create our own images but we should keep it simple and small"
execute_command cat app/Dockerfile
execute_command docker build -t myapp:0.1-alpha app

print_and_wait "All and all we've ended up with these images in the end"
execute_command docker images

print_and_wait "Let's clean up"
print_and_wait "Removing an image is just as simple. Notice that wherever we use a specific tag we must provide it for deletion. Also notice the registry name as well."
execute_command docker rmi alpine alpine:3.19.0 docker.elastic.co/beats/elastic-logging-plugin:7.6.1
print_and_wait "Alternative way:"
execute_command docker image rm myapp:0.1-alpha
