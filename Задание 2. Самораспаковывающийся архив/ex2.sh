#!/bin/bash
#dir_path параметр - путь к каталогу содержимое которого нужно упаковать
#name - наименование самораспаковывающегося архива
while getopts "d:n:" option
do
  case $option in
    n ) name="$OPTARG";;
    d ) dir_path="$OPTARG";;
  esac
done

#файл tar для работы с архивом
arch=$(tar -cz $dir_path | base64)

# создание скрипта и его сохранение под именем name.sh
echo "#!/bin/bash
arch=\"$arch\"
while getopts \"o:\" opt 
do
    case \$opt in
    o ) unpackdir="\$OPTARG";;
    esac
done
if [ \$unpackdir ]
then
    echo \"\$arch\" | base64 --decode | tar -xvz -C \$unpackdir
else
    echo \"\$arch\" | base64 --decode | tar -xvz 
fi" > $name.sh

# Всем предоставить доступ на чтение/изменение файла
chmod 777 $name.sh