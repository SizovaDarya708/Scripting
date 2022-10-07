

RED='\e[31m'
GREEN='\e[32m'
RESET='\e[0m'
right=0
wrong=0
VALIDATION = "Пожалуйста, повторите попытку, необходимо ввести цифру от 0 до 9"
EXIT_MESSAGE = "Программа завершена"
WIN_MESSAGE = "Цифра угадана!"
GAME_OVER_MESSAGE = "Не угадали!"

while [[ true ]]; do
	rnd=$(shuf -i 0-9 -n 1)
		
	read -p "Я загадал цифру, попробуйте угадать ее!" input

	[[ "${input}" == 'q' ]] && { echo "${EXIT_MESSAGE}"; exit 0; }

	[[ "${input}" =~ ^[0-9]$ ]] || { echo "${VALIDATION_MESSAGE}"; continue; }

	if (( "${input}" == rnd )); then
		right=$((right+1))
		random_list+="${RED}${rnd}${RESET}"
		echo "${WIN_MESSAGE}"
	else
		wrong=$((wrong+1))
		random_list+="${RED}${rnd}${RESET}"
		echo "${GAME_OVER_MESSAGE}"
	fi

	STATISTIC=$((right*100/(right+wrong)))

	echo "Вы угадали: ${STATISTIC}%, Вы не угадали: $((100-STATISTIC))%"
	echo "Результаты рандомайзера: ${random_list[@]}"

done