#!/bin/bash
#параметры к программе - 
#dirpath - каталог с файлами для обработки
#command - путь к исполняемому файлу
#mask используются символы Pattern Matching
#number - максимальное количество одновременно запущенных процессов

while getopts "d:e:c:n:" OPT; do
  case "$OPT" in
    d)
      declare -r dirpath="$OPTARG"
      ;;
    e)
      declare -r mask="$OPTARG"
      ;;
    c)
      declare -r command="$OPTARG"
      ;;
    n)
      declare -r number="$OPTARG"
      ;;
    *)
      exit 1
      ;;
  esac
done

for parname in dirpath mask command number; do
  declare -n par=$parname
  if [ -z "$par" ]; then
    echo "Не указан параметр $parname"
    exit 1
  fi
done

function next_file() {
    declare -n arr="files"
    if [ ${#arr[@]} -gt 0 ]; then
      NEXT_FILE="${arr[${#arr[@]}-1]}"
      unset "arr[${#arr[@]}-1]"
      return 0
    fi
    return 1
}

function wait_proccess() {
    wait -n
    wait_status=$?
    while [ $wait_status -gt 127 ]; do
      wait -n
      wait_status=$?
    done
}

declare -r path="$dirpath/$mask"
declare -a files=( $path )
file_count=${#files[@]}
declare -i LEFT_COUNT=$file_count
declare -i PROCESSED_COUNT=0
min=$((number < file_count ? number : file_count))
for _ in $(seq 1 $min); do
    next_file
    eval $command $NEXT_FILE &
done
while : ; do
  wait_proccess
  LEFT_COUNT=$((LEFT_COUNT-1))
  PROCESSED_COUNT=$((PROCESSED_COUNT+1))
  if [ ${#files[@]} -gt 0 ]; then
      next_file
      eval $command $NEXT_FILE &
  fi
  if [ $LEFT_COUNT -eq 0 ]; then
      break
  fi
done
wait
echo 'END'