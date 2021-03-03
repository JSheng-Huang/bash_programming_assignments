function generate_rand(){
    echo "This function will generate 10 integers randomly(the range is between your following 2 inputs) and calculate the average."
    
    read -p "Please input your lower bound: " lowerBound

    while [[ ! "${lowerBound}" =~ ^[0-9]+$ ]]
    do
        echo "Positive integer only!"
        read -p "Please input your lower bound: " lowerBound
    done

    read -p "Please input your upper bound: " upperBound

    while ! [[ "${upperBound}" =~ ^[0-9]+$ ]] || [[ "${lowerBound}" -gt "${upperBound}" ]]
    do
        echo "Upper bound must be greater than lower bound and be a positive integer!"
        read -p "Please input your upper bound: " upperBound
    done

    sum=0

    for i in $(seq 10)
    do
        sum=$(("${sum}"+$(shuf -i ${lowerBound}-${upperBound} -n 1)))
    done

    average=$(echo "scale=2; ${sum}/10" | bc)
    datetime=$(date +%Y-%m-%dT%H:%M:%S%z)
    
    echo "${average}" > average_"${datetime}".txt
}

function read_dataset(){
    echo "This function will read the input data (integers) from an existing data set stored in your given file."

    read -p "The path of your given file: " filePath

    while [ ! -f "${filePath}" ]
    do
        echo "The path which you input is wrong."
        read -p "The path of your given file: " filePath
    done

    tempStr=""
    counter=0

    while read line || [ -n "${line}" ]
    do
        n=1
        sum=0
        counter=$(("${counter}"+1))

        until [ "${n}" == 11 ]
        do 
            sum=$(("${sum}"+$(echo "${line}" | cut -d "," -f "${n}")))
            n=$(("${n}"+1))
        done
        
        average=$(echo "scale=2; ${sum}/10" | bc)
        
        tempStr="${tempStr}""${average}",

        if [ "${counter}" != 0 ] && [ $(("${counter}"%10)) == 0 ]
        then
          tempStr=$(echo "${tempStr}" | sed "s/,$/\n /") 
        fi

    done < "${filePath}"
    
    datetime=$(date +%Y-%m-%dT%H:%M:%S%z)
    
    average=$(echo "${tempStr}" | sed "s/,$//g")
    echo "${average}" > average_"${datetime}".txt
}

echo "Please input 1 or 2 to use this program."
echo "1: Generate the input data (integers) randomly between the user-specified range."
echo "2: Read the input data (integers) from an existing data set stored in a given file."
echo "Others: Exit."

read -p "Your choice: " choice

case "${choice}" in
  1)
    generate_rand;
    ;;
  2)
    read_dataset;
    ;;
  *)
    echo "Have already exited"
    ;;
esac