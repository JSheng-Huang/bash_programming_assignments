n=1

until [ "${n}" -gt 11 ]
do 
    echo "${n}"
    n=$(("${n}"+1))
done