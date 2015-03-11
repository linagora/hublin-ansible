#! /bin/bash

echo "### Building Docker image"
docker build -t hublin .

echo "### Running a shell in built image"
[ $? -eq 0 ] && docker run -i -t hublin /bin/bash

