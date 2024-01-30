#! /bin/zsh 

for d in '2.prompts'/*/; do 
    ./mk_latex.sh "${d}"
done

for d in '3.frags'/*/; do 
    ./wrangle.sh "${d}" 
done

# IF THERE IS AN ARG CONTAINING A FILENAME, CAT THE JSONL FILES 

if [[ "${1}" != '' ]]; then 
    dn=$(dirname "${1}"); 
    if [[ "${dn}" != '.' ]]; then 
        echo 'PROCESSES ALL PROMPTS TO JSONL'; 
        echo 'ONE OPTIONAL ARG FOR FILE NAME'; 
        echo 'ERR: MUST NOT INCLUDE DIR'; 
        exit; 
    fi

    fn="5.training_docs/${1}"; 
    cat "4.jsonl"/*.jsonl > "${fn}"; 
    sed -i '' '/^\s*$/d' "${fn}"; 
fi