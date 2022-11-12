#!/bin/bash
arch="H4sIAAAAAAAAA+3R0QqCMBSA4T3KnqDO5k4+TgguEkaCLujxU0LyJoNQIvq/mzPYYAf+HPt8PLWp
jt3ebEQGpeo4XakynxPjglPxKkGCEecLXxirWy00d+1z1Vlr6urSpIV37+5/VJ71f5ybFHf5llf8
Ywx8CGGhvz77Oz/0VymCsbLiDi/9ef9zTKn99hIAAAAAAAAAAAAAAAAAPnIHbfNT8QAoAAA="
while getopts "o:" opt 
do
    case $opt in
    o ) path=$OPTARG;;
    esac
done
if [ $path ]
then
    echo "$arch" | base64 --decode | tar -xvz -C $path
else
    echo "$arch" | base64 --decode | tar -xvz 
fi
