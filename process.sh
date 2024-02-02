#! /bin/zsh 

for d in 'prompts'/*/; do 
    ./mk_latex.sh "${d}"
done

for d in 'fragments'/*/; do 
    ./wrangle.sh "${d}" 
done

# IF THERE IS AN ARG CONTAINING A FILENAME, CAT THE JSONL FILES 

if [[ "${1}" != '' ]]; then 
    dn=$(dirname "${1}"); 
    if [[ "${dn}" != '.' ]]; then 
        echo 'PROCESSES ALL PROMPTS TO TRAINING DOC'; 
        echo 'ONE OPTIONAL ARG FOR FILE NAME'; 
        echo 'ERR: MUST NOT INCLUDE DIR'; 
        exit; 
    fi

    fn="montage/${1}"; 
    cat "training"/*.jsonl > "${fn}"; 
    sed -i '' '/^\s*$/d' "${fn}"; 
fi