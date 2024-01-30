#! /bin/zsh 

# DIRECTORY TO CONVERT 

if [[ ! -d "${1}" ]]; then 
    echo "CONVERT FRAGS IN A DIR TO JSONL"; 
    echo "ERR: NEED ONE ARG SPECIFYING DIR"; 
    exit; 
fi 
src_dir="${1%/}"; 

# JSONL LINE TEMPLATE 

declare -a TEMPLATE=('{"messages":[{"role":"system","content":""},{"role":"user","content":"' '"},{"role":"assistant","content":' '}]}' )

# OUT FILE 

out_file=$(echo "${1%/}" | grep -Eo "[^/]+$"); 
out_file="4.jsonl/${out_file}.jsonl"; 
echo "" > "${out_file}"; 

# ITERATE OVER FILES 

for f in "${src_dir}"/*.tex; do 

    # USER CONTENT IS THE TEX FILENAME 

    usr_content=$(echo "${f}" | grep -Eo "[^/]+$"); 
    usr_content="${usr_content%.tex}";  

    # PROCESS TEX CONTENT FOR JSON 

    asst_content=$(<"${f}"); 
    asst_content=$(jq -n --arg content "${asst_content}" '$content | @json'); 

    # APPEND TO OUT FILE 

    echo "PREPARING: ${usr_content}…"; 
    echo "${TEMPLATE[1]}${usr_content}${TEMPLATE[2]}${asst_content}${TEMPLATE[3]}" >> "${out_file}"; 
done 